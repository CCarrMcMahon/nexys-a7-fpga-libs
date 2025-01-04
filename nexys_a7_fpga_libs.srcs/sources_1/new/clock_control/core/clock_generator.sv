/**
 * @module clock_generator
 * @brief Generates a configurable clock signal.
 *
 * This module generates a configurable clock signal from an input clock by implementing a digital
 * clock divider. If the input and output frequencies are the same, the module will bypass the
 * divider and directly output the input clock signal while accounting for the IDLE_VALUE. It
 * supports customizable frequency division, phase shifting, and duty cycle adjustment. The module
 * also includes synchronization for control signals and maintains clock phase alignment when
 * disabled and re-enabled.
 *
 * @param CLK_IN_FREQ Input clock frequency in Hz (0.0, clk freq]
 * @param CLK_OUT_FREQ Output clock frequency in Hz (0.0, CLK_IN_FREQ]
 * @param PHASE_SHIFT Phase shift as percentage of clock period [0.0, 100.0]
 * @param DUTY_CYCLE Duty cycle as percentage of clock period [0.0, 100.0]
 * @param IDLE_VALUE Output value when clock is disabled [0, 1]
 *
 * @input clk Main clock signal
 * @input rst Asynchronous reset signal
 * @input clear Synchronous clear signal (2-cycle delay)
 * @input enable Clock generation enable (2-cycle delay)
 *
 * @output clk_out Generated clock signal
 *
 * @designer Christopher McMahon
 * @date 12-22-2024
 */
module clock_generator #(
    parameter real  CLK_IN_FREQ  = 100_000_000,
    parameter real  CLK_OUT_FREQ = 1_000_000,
    parameter real  PHASE_SHIFT  = 0.0,
    parameter real  DUTY_CYCLE   = 50.0,
    parameter logic IDLE_VALUE   = 0
) (
    // Main clock and reset signals
    input logic clk,
    input logic rst,

    // Clock generation control signals
    input logic clear,
    input logic enable,

    // Clock output signal
    output logic clk_out
);

    // Constants for the clock generation
    localparam real DivisionRatio = CLK_IN_FREQ / CLK_OUT_FREQ;  // [1.0, INF)
    localparam integer ClockDivisionRatio = int'(DivisionRatio);  // [1, INF)
    localparam integer PhaseOffset = int'(DivisionRatio * (PHASE_SHIFT / 100.0));  // [0, Ratio]
    localparam integer PulseWidth = int'(DivisionRatio * (DUTY_CYCLE / 100.0));  // [0, Ratio]
    localparam integer CounterBits = $clog2(ClockDivisionRatio + 1);  // [1, INF)

    // Counter to generate the clock signal based on the divider
    logic [CounterBits-1:0] counter;

    // Flag to indicate when the phase offset is done
    logic offset_done;

    // Synchronized control signals
    logic sync_clear;
    logic sync_enable;

    // Instantiate a 2-ff synchronizer for the clear signal
    multi_flop_synchronizer #(
        .STAGES(2)
    ) clear_synchronizer (
        .clk(clk),
        .rst(rst),
        .async_signal(clear),
        .sync_signal(sync_clear)
    );

    // Instantiate a 2-ff synchronizer for the enable signal
    multi_flop_synchronizer #(
        .STAGES(2)
    ) enable_synchronizer (
        .clk(clk),
        .rst(rst),
        .async_signal(enable),
        .sync_signal(sync_enable)
    );

    // Counter logic
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            offset_done <= 0;
        end else if (ClockDivisionRatio != 1) begin
            if (sync_clear) begin
                counter <= 0;
                offset_done <= 0;
            end else if (sync_enable) begin
                // Increment the counter until the ClockDivisionRatio is reached
                if (counter == ClockDivisionRatio - 1) begin
                    counter <= 0;
                    offset_done <= 1;
                end else begin
                    counter <= counter + 1;
                end

                // Set the offset done flag when the phase offset is reached
                if (!offset_done && counter == PhaseOffset) begin
                    counter <= 0;
                    offset_done <= 1;
                end
            end
        end
    end

    // Clock generation logic
    always_comb begin
        // Direct bypass when frequencies match
        if (ClockDivisionRatio == 1) begin
            if (!sync_clear && sync_enable) begin
                clk_out = (IDLE_VALUE == 0) ? clk : ~clk;
            end else begin
                clk_out = IDLE_VALUE;
            end
        end else begin
            if (sync_enable && offset_done && counter < PulseWidth) begin
                clk_out = ~IDLE_VALUE;
            end else begin
                clk_out = IDLE_VALUE;
            end
        end
    end

endmodule
