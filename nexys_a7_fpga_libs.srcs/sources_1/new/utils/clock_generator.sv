/**
 * @module clock_generator
 * @brief Generates a configurable clock signal.
 *
 * This module generates a configurable clock signal from an input clock by implementing
 * a digital clock divider. It supports customizable frequency division, phase shifting,
 * and duty cycle adjustment. The module includes synchronization for control signals
 * and maintains clock phase alignment when disabled and re-enabled.
 *
 * @param CLK_IN_FREQ Input clock frequency in Hz (default: 100_000_000)
 * @param CLK_OUT_FREQ Output clock frequency in Hz (default: 1_000_000)
 * @param PHASE_SHIFT Phase shift of the output clock as a percentage of the period (default: 0.0)
 * @param DUTY_CYCLE Duty cycle of the output clock as a percentage of the period (default: 50.0)
 * @param IDLE_VALUE Idle value of the output clock (default: 0)
 *
 * @input clk Main clock signal
 * @input rst Asynchronous reset signal
 * @input clear Synchronous clear signal for resetting clock generation
 * @input enable Enable signal to start/stop clock generation while maintaining phase
 *
 * @output clk_out Generated clock signal
 *
 * @designer Christopher McMahon
 * @date 12-21-2024
 */
module clock_generator #(
    parameter integer CLK_IN_FREQ = 100_000_000,
    parameter integer CLK_OUT_FREQ = 1_000_000,
    parameter real PHASE_SHIFT = 0.0,
    parameter real DUTY_CYCLE = 50.0,
    parameter logic IDLE_VALUE = 0
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
    localparam integer ClockDivisionRatio = CLK_IN_FREQ / CLK_OUT_FREQ;
    localparam integer PhaseOffset = ClockDivisionRatio * (PHASE_SHIFT / 100.0);
    localparam integer PulseWidth = ClockDivisionRatio * (DUTY_CYCLE / 100.0);

    // Counter to generate the clock signal based on the divider
    logic [$clog2(ClockDivisionRatio)-1:0] counter;

    // Flag to indicate when the phase offset is done
    logic offset_done;

    // Synchronized control signals
    logic sync_clear;
    logic sync_enable;

    // Instantiate synchronizer for clear signal
    synchronizer #(
        .STAGES(2)
    ) clear_synchronizer (
        .clk(clk),
        .rst(rst),
        .async_signal(clear),
        .sync_signal(sync_clear)
    );

    // Instantiate synchronizer for enable signal
    synchronizer #(
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
            clk_out <= IDLE_VALUE;
            offset_done <= 0;
        end else if (sync_clear) begin
            counter <= 0;
            clk_out <= IDLE_VALUE;
            offset_done <= 0;
        end else if (!sync_enable) begin
            // Don't reset the counter so the clock can be resumed
            clk_out <= IDLE_VALUE;
        end else begin
            if (offset_done || counter == PhaseOffset) begin
                offset_done <= 1;
                if (counter < PulseWidth) begin
                    clk_out <= ~IDLE_VALUE;
                    counter <= counter + 1;
                end else begin
                    clk_out <= IDLE_VALUE;
                    if (counter == ClockDivisionRatio - 1) begin
                        counter <= 0;
                    end else begin
                        counter <= counter + 1;
                    end
                end
            end else begin
                if (counter == PhaseOffset) begin
                    counter <= 0;
                    offset_done <= 1;
                end else begin
                    counter <= counter + 1;
                end
            end
        end
    end

endmodule
