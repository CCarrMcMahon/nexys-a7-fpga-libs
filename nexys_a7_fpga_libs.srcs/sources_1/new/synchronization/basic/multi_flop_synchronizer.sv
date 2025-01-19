/**
 * @module multi_flop_synchronizer
 * @brief Synchronizes an asynchronous signal to a clock domain.
 *
 * This module synchronizes an asynchronous signal to a clock domain using a chain of flip-flops.
 * The number of stages can be configured using the STAGES parameter. The input signal is shifted
 * into the chain of flip-flops on the rising edge of the clock. The synchronized signal is output
 * on the last stage of the chain.
 *
 * @param  STAGES        Number of synchronization stages, must be >= 2 (default: 2)
 *
 * @input  clk           Main clock signal
 * @input  rst           Asynchronous reset signal
 * @input  async_signal  Asynchronous input signal
 *
 * @output sync_signal   Synchronized output signal
 *
 * @designer  Christopher McMahon
 * @created   12-19-2024
 * @modified  01-19-2025
 */
module multi_flop_synchronizer #(
    parameter int STAGES = 2
) (
    // Main clock and reset signals
    input logic clk,
    input logic rst,

    // Asynchronous input signal
    input logic async_signal,

    // Synchronized output signal
    output logic sync_signal
);

    // Constants
    localparam int unsigned Stages = (STAGES >= 2) ? STAGES : 2;

    // Register array to hold synchronization stages
    logic [Stages-1:0] sync_stages;

    // Synchronization process triggered on the rising edge of the clock or reset
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset the synchronization stages to 0
            sync_stages <= {Stages{1'b0}};
        end else begin
            // Shift in the async signal
            sync_stages <= {sync_stages[Stages-2:0], async_signal};
        end
    end

    // Output the signal synchronized to the clock domain
    assign sync_signal = sync_stages[Stages-1];

endmodule
