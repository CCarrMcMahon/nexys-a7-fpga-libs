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
 * @param  WIDTH       Number of bits in the data bus [1, INF)
 * @param  DEPTH       Number of entries in the FIFO buffer [2, INF)
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
    localparam int unsigned Width = (WIDTH >= 1) ? WIDTH : 1;
    localparam int unsigned Depth = (DEPTH >= 2) ? DEPTH : 2;
    localparam int unsigned PtrWidth = $clog2(Depth);

    // TODO: Move to a common package so they can be shared across modules
    typedef enum logic [4:0] {
        Empty = 5'b00001,
        AlmostEmpty = 5'b00010,
        HalfFull = 5'b00100,
        AlmostFull = 5'b01000,
        Full = 5'b10000
    } status_flags_t;

    typedef enum logic [2:0] {
        RESET_WRITE,
        WAIT_DIN_VALID,
        WRITE_BUFFER,
        INCR_WRITE_PTR,
        WAIT_DIN_INVALID
    } write_state_t;

    typedef enum logic [1:0] {
        RESET_READ,
        WAIT_DOUT_ACKED,
        WAIT_DOUT_NACKED,
        INCR_READ_PTR
    } read_state_t;

    // State variables
    write_state_t curr_write_state, next_write_state;
    read_state_t curr_read_state, next_read_state;

    // Buffer signals
    logic [Width-1:0] buffer[Depth];
    logic [PtrWidth-1:0] write_ptr;
    logic [PtrWidth-1:0] read_ptr;
    logic [PtrWidth-1:0] buffer_depth;  // Careful with calculation to avoid overflow
    logic write_ptr_wrapped;
    logic read_ptr_wrapped;

    // Synchronized signals
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
                if (!is_full && din_valid_synced) begin
                    next_write_state = WRITE_BUFFER;
                end
            end
            WRITE_BUFFER: begin
                next_write_state = INCR_WRITE_PTR;
            end
            INCR_WRITE_PTR: begin
                next_write_state = WAIT_DIN_INVALID;
            end
            WAIT_DIN_INVALID: begin
                if (!din_valid_synced) begin
                    next_write_state = WAIT_DIN_VALID;
                end
            end
            default: begin
                next_write_state = RESET_WRITE;
            end
        endcase
    end

    // Write buffer logic
    always_ff @(posedge clk) begin
        unique case (curr_write_state)
            RESET_WRITE: begin
                ack_din <= 1'b0;
                write_ptr <= '0;
                write_ptr_wrapped <= 1'b0;
            end
            WAIT_DIN_VALID: begin
                ack_din <= 1'b0;
            end
            WRITE_BUFFER: begin
                buffer[write_ptr] <= din;
            end
            INCR_WRITE_PTR: begin
                if (write_ptr == DEPTH - 1) begin
                    write_ptr <= '0;
                    write_ptr_wrapped <= ~write_ptr_wrapped;
                end else begin
                    write_ptr <= write_ptr + 1;
                end
            end
            WAIT_DIN_INVALID: begin
                ack_din <= 1'b1;
            end
            default: begin
                // No Action: State machine will reset
            end
        endcase
    end

    // Next read state transition logic
    always_comb begin
        next_read_state = curr_read_state;

        unique case (curr_read_state)
            RESET_READ: begin
                next_read_state = WAIT_DOUT_ACKED;
            end
            WAIT_DOUT_ACKED: begin
                if (!is_empty && dout_acked_synced) begin
                    next_read_state = WAIT_DOUT_NACKED;
                end
            end
            WAIT_DOUT_NACKED: begin
                if (!dout_acked_synced) begin
                    next_read_state = INCR_READ_PTR;
                end
            end
            INCR_READ_PTR: begin
                next_read_state = WAIT_DOUT_ACKED;
            end
            default: begin
                next_read_state = RESET_READ;
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
                read_ptr_wrapped <= 1'b0;
            end
            WAIT_DOUT_ACKED: begin
                dout <= buffer[read_ptr];
                dout_valid <= !is_empty;
            end
            WAIT_DOUT_NACKED: begin
                dout_valid <= 1'b0;
            end
            INCR_READ_PTR: begin
                if (read_ptr == DEPTH - 1) begin
                    read_ptr <= '0;
                    read_ptr_wrapped <= ~read_ptr_wrapped;
                end else begin
                    read_ptr <= read_ptr + 1;
                end
            end
            default: begin
                // No Action: State machine will reset
            end
        endcase
    end

    // Status logic
    always_comb begin
        // Set default values
        buffer_depth = '0;
        status = '0;

        // Calculate the buffer depth
        if (write_ptr >= read_ptr) begin
            // Both empty and full conditions have a depth of 0 to avoid overflow
            buffer_depth = write_ptr - read_ptr;
        end else begin
            buffer_depth = DEPTH - read_ptr + write_ptr;
        end

        // Update the status flags
        if (buffer_depth == 0) begin
            // Both empty and full conditions have 0 depth so compare wrapped values
            if (write_ptr_wrapped == read_ptr_wrapped) begin
                status = status | status_flags_t'({Empty});
                status = status | status_flags_t'({AlmostEmpty});
            end else begin
                status = status | status_flags_t'({HalfFull});
                status = status | status_flags_t'({AlmostFull});
                status = status | status_flags_t'({Full});
            end
        end else begin
            if (buffer_depth <= 1) begin
                status = status | status_flags_t'({AlmostEmpty});
            end
            if (buffer_depth >= (DEPTH + 1) / 2) begin
                status = status | status_flags_t'({HalfFull});
            end
            if (buffer_depth >= DEPTH - 1) begin
                status = status | status_flags_t'({AlmostFull});
            end
        end
    end

    // Assignments
    assign is_empty = (status & status_flags_t'(Empty)) == status_flags_t'(Empty);
    assign is_full  = (status & status_flags_t'(Full)) == status_flags_t'(Full);

endmodule
