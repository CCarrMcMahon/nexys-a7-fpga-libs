/**
 * @module fifo_buffer
 * @brief A parameterized First-In-First-Out (FIFO) buffer implementation.
 *
 * This module implements a synchronous FIFO buffer with a configurable width and depth. It includes
 * synchronous control signals as well as status flags to indicate the current state of the FIFO.
 * The FIFO buffer is implemented using a circular buffer with separate read and write pointers. It
 * also utilizes a handshaking mechanism to ensure that data is only read or written once the other
 * side has acknowledged the operation.
 *
 * @param  WIDTH       Number of bits in the data bus (default: 8)
 * @param  DEPTH       Number of entries in the FIFO buffer (default: 256)
 *
 * @input  clk         Main clock signal
 * @input  rst         Asynchronous reset signal
 * @input  clear       Synchronous clear signal to reset the FIFO buffer
 * @input  din         Input data bus [WIDTH-1:0]
 * @input  din_valid   Signal indicating valid input data
 * @input  dout_acked  Incoming signal to acknowledge output data has been read
 *
 * @output dout        Output data bus [WIDTH-1:0]
 * @output dout_valid  Signal indicating valid output data
 * @output ack_din     Outgoing signal to acknowledge input data has been written
 * @output status      Status flags [4:0] (Full, AlmostFull, HalfFull, AlmostEmpty, Empty)
 */
module fifo_buffer #(
    parameter int WIDTH = 8,
    parameter int DEPTH = 256
) (
    // Main clock and reset signals
    input logic clk,
    input logic rst,

    // Control signals
    input logic clear,

    // Data input signals
    input logic [WIDTH-1:0] din,
    input logic din_valid,
    input logic dout_acked,

    // Data output signals
    output logic [WIDTH-1:0] dout,
    output logic dout_valid,
    output logic ack_din,

    // Status signals
    output logic [4:0] status
);

    // Constants
    // TODO: Move to a common package so they can be shared across modules
    typedef enum logic [4:0] {
        Empty = 5'b00001,
        AlmostEmpty = 5'b00010,
        HalfFull = 5'b00100,
        AlmostFull = 5'b01000,
        Full = 5'b10000
    } status_flags_t;

    typedef enum logic [1:0] {
        RESET_WRITE,
        WAIT_DIN_VALID,
        WRITE_BUFFER,
        WAIT_DIN_INVALID
    } write_state_t;

    typedef enum logic [1:0] {
        RESET_READ,
        WAIT_DOUT_VALID,
        WAIT_DOUT_INVALID,
        READ_BUFFER
    } read_state_t;

    // Internal signals
    write_state_t curr_write_state, next_write_state;
    read_state_t curr_read_state, next_read_state;

    logic [WIDTH-1:0] buffer[DEPTH];
    logic [$clog2(DEPTH)-1:0] write_ptr;
    logic [$clog2(DEPTH)-1:0] read_ptr;
    logic [$clog2(DEPTH)-1:0] buffer_depth;

    logic clear_synced;
    logic din_valid_synced;
    logic dout_acked_synced;

    multi_flop_synchronizer #(
        .STAGES(2)
    ) sync_clear (
        .clk(clk),
        .rst(rst),
        .async_signal(clear),
        .sync_signal(clear_synced)
    );

    multi_flop_synchronizer #(
        .STAGES(2)
    ) sync_din_valid (
        .clk(clk),
        .rst(rst),
        .async_signal(din_valid),
        .sync_signal(din_valid_synced)
    );

    multi_flop_synchronizer #(
        .STAGES(2)
    ) sync_dout_acked (
        .clk(clk),
        .rst(rst),
        .async_signal(dout_acked),
        .sync_signal(dout_acked_synced)
    );

    // Current state transition logic
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            curr_write_state <= RESET_WRITE;
            curr_read_state  <= RESET_READ;
        end else if (clear_synced) begin
            curr_write_state <= RESET_WRITE;
            curr_read_state  <= RESET_READ;
        end else begin
            curr_write_state <= next_write_state;
            curr_read_state  <= next_read_state;
        end
    end

    // Next write state transition logic
    always_comb begin
        next_write_state = curr_write_state;

        unique case (curr_write_state)
            RESET_WRITE: begin
                next_write_state = WAIT_DIN_VALID;
            end
            WAIT_DIN_VALID: begin
                if ((status & status_flags_t'(Full)) != status_flags_t'(Full)) begin
                    if (din_valid_synced) begin
                        next_write_state = WRITE_BUFFER;
                    end
                end
            end
            WRITE_BUFFER: begin
                next_write_state = WAIT_DIN_INVALID;
            end
            WAIT_DIN_INVALID: begin
                // Wait for the input data to stop being valid indicating the ack has been received
                if (!din_valid_synced) begin
                    next_write_state = WAIT_DIN_VALID;
                end
            end
        endcase
    end

    // Write buffer logic
    always_ff @(posedge clk) begin
        unique case (curr_write_state)
            RESET_WRITE: begin
                ack_din   <= 1'b0;
                write_ptr <= '0;
            end
            WAIT_DIN_VALID: begin
                ack_din <= 1'b0;
            end
            WRITE_BUFFER: begin
                buffer[write_ptr] <= din;
                write_ptr <= (write_ptr + 1) % DEPTH;
            end
            WAIT_DIN_INVALID: begin
                ack_din <= 1'b1;
            end
        endcase
    end

    // Next read state transition logic
    always_comb begin
        next_read_state = curr_read_state;

        unique case (curr_read_state)
            RESET_READ: begin
                next_read_state = WAIT_DOUT_VALID;
            end
            WAIT_DOUT_VALID: begin
                if ((status & status_flags_t'(Empty)) != status_flags_t'(Empty)) begin
                    if (dout_acked_synced) begin
                        next_read_state = WAIT_DOUT_INVALID;
                    end
                end
            end
            WAIT_DOUT_INVALID: begin
                if (!dout_acked_synced) begin
                    next_read_state = READ_BUFFER;
                end
            end
            READ_BUFFER: begin
                next_read_state = WAIT_DOUT_VALID;
            end
        endcase
    end

    // Read buffer logic
    always_ff @(posedge clk) begin
        unique case (curr_read_state)
            RESET_READ: begin
                dout <= '0;
                dout_valid <= 1'b0;
                read_ptr <= '0;
            end
            WAIT_DOUT_VALID: begin
                // There is valid data in the FIFO if the write and read pointers are not equal
                dout_valid <= (write_ptr != read_ptr);
            end
            WAIT_DOUT_INVALID: begin
                dout_valid <= 1'b0;
            end
            READ_BUFFER: begin
                dout <= buffer[read_ptr];
                read_ptr <= (read_ptr + 1) % DEPTH;
            end
        endcase
    end

    // Status logic
    always_comb begin
        // Calculate the buffer depth
        buffer_depth = DEPTH - 1;
        if (write_ptr >= read_ptr) begin
            buffer_depth = write_ptr - read_ptr;
        end else begin
            buffer_depth = DEPTH - read_ptr + write_ptr;
        end

        // Update the status flags
        status = 5'b00000;
        if (buffer_depth == 0) begin
            status = status | status_flags_t'({Empty});
        end
        if (buffer_depth <= 1) begin
            status = status | status_flags_t'({AlmostEmpty});
        end
        if (buffer_depth >= DEPTH / 2) begin
            status = status | status_flags_t'({HalfFull});
        end
        if (buffer_depth >= DEPTH - 2) begin
            status = status | status_flags_t'({AlmostFull});
        end
        if (buffer_depth == DEPTH - 1) begin
            status = status | status_flags_t'({Full});
        end
    end

endmodule
