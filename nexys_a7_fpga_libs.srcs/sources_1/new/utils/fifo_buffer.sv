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

    // Status flags
    localparam int Full = 5'b10000;
    localparam int AlmostFull = 5'b01000;
    localparam int HalfFull = 5'b00100;
    localparam int AlmostEmpty = 5'b00010;
    localparam int Empty = 5'b00001;

    // State definitions
    typedef enum logic [1:0] {
        RESET,
        IDLE,
        WRITE,
        READ
    } state_t;
    state_t curr_state, next_state;

    // Internal buffer
    logic [WIDTH-1:0] buffer[DEPTH];

    // Internal pointers
    logic [$clog2(DEPTH)-1:0] write_ptr;
    logic [$clog2(DEPTH)-1:0] read_ptr;
    logic [$clog2(DEPTH+1)-1:0] fifo_depth;

    // Synchronized control signals
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
            curr_state <= RESET;
        end else if (clear_synced) begin
            curr_state <= RESET;
        end else begin
            curr_state <= next_state;
        end
    end

    // Next state transition logic
    always_comb begin
        next_state = curr_state;

        case (curr_state)
            RESET: begin
                next_state = IDLE;
            end
            IDLE: begin
                // Priority: read > write
                if (!status[Empty] && dout_acked_synced) begin
                    next_state = READ;
                end else if (!status[Full] && din_valid_synced) begin
                    next_state = WRITE;
                end
            end
            WRITE: begin
                next_state = IDLE;
            end
            READ: begin
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // FIFO buffer logic
    always_ff @(posedge clk) begin
        unique case (curr_state)
            RESET: begin
                dout <= '0;
                ack_din <= 1'b0;
                write_ptr <= '0;
                read_ptr <= '0;
                fifo_depth <= '0;
            end
            IDLE: begin
                ack_din <= 1'b0;
            end
            WRITE: begin
                buffer[write_ptr] <= din;
                write_ptr <= (write_ptr + 1) % DEPTH;
                fifo_depth <= fifo_depth + 1;
                ack_din <= 1'b1;
            end
            READ: begin
                dout <= buffer[read_ptr];
                read_ptr <= (read_ptr + 1) % DEPTH;
                fifo_depth <= fifo_depth - 1;
            end
        endcase
    end

    // Status logic
    always_comb begin
        status[Full] = (fifo_depth == DEPTH);
        status[AlmostFull] = (fifo_depth >= DEPTH - 1);
        status[HalfFull] = (fifo_depth >= DEPTH / 2);
        status[AlmostEmpty] = (fifo_depth <= 1);
        status[Empty] = (fifo_depth == 0);
    end

    // There is valid data in the FIFO if the write and read pointers are not equal
    assign dout_valid = (write_ptr != read_ptr);

endmodule
