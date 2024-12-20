/**
 * @module pulse_generator
 * @brief Generates a pulse with configurable frequency, width, and offset.
 *
 * This module generates a pulse with a configurable frequency, width, and offset. The pulse is generated on the rising
 * edge of the clock when the enable signal is high. The pulse can be cleared asynchronously using the clear signal.
 *
 * @param CLK_FREQ Clock frequency in Hz (default: 100 MHz)
 * @param PULSE_FREQ Pulse frequency in Hz (default: 100 Hz)
 * @param WIDTH_PERCENT Width of the pulse as a percentage of the period (default: 10%)
 * @param OFFSET_PERCENT Offset to the start of the pulse as a percentage of the period (default: 0%)
 *
 * @input clk Input clock
 * @input rst Reset signal
 * @input enable Enable signal
 * @input clear Clear signal
 *
 * @output pulse_output Pulse output signal
 *
 * @designer Christopher McMahon
 * @date 12-20-2024
 */
module pulse_generator #(
    parameter integer CLK_FREQ = 100_000_000,
    parameter integer PULSE_FREQ = 100,
    parameter integer WIDTH_PERCENT = 10,
    parameter integer OFFSET_PERCENT = 0
) (
    // Main clock and reset signals
    input logic clk,
    input logic rst,

    // Enable and clear signals for pulse generation
    input logic enable,
    input logic clear,

    // Pulse output signal
    output logic pulse_output
);

    // Calculate the number of clock cycles for the period, width, and offset
    localparam integer PulsePeriod = CLK_FREQ / PULSE_FREQ;
    localparam integer PulseWidth = (PulsePeriod * WIDTH_PERCENT) / 100;
    localparam integer PulseOffset = (PulsePeriod * OFFSET_PERCENT) / 100;

    // Counter to keep track of the current clock cycle within the period
    logic [$clog2(PulsePeriod)-1:0] counter;

    // Synchronized enable and clear signals
    logic sync_enable;
    logic sync_clear;

    // Instantiate synchronizer for enable signal
    synchronizer #(
        .STAGES(2)
    ) enable_synchronizer (
        .clk(clk),
        .rst(rst),
        .async_signal(enable),
        .sync_signal(sync_enable)
    );

    // Instantiate synchronizer for clear signal
    synchronizer #(
        .STAGES(2)
    ) clear_synchronizer (
        .clk(clk),
        .rst(rst),
        .async_signal(clear),
        .sync_signal(sync_clear)
    );

    // Pulse generation process triggered on the rising edge of the clock or reset
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset the counter to 0 and pulse output to low
            counter <= 0;
            pulse_output <= 0;
        end else if (sync_clear) begin
            // Clear the pulse output and reset the counter to 0
            counter <= 0;
            pulse_output <= 0;
        end else if (sync_enable) begin
            if (counter < PulsePeriod - 1) begin
                counter <= counter + 1;
            end else begin
                counter <= 0;
            end

            // Generate the pulse based on the counter value and pulse width
            if (PulseOffset <= counter && counter < PulseOffset + PulseWidth) begin
                pulse_output <= 1;
            end else begin
                pulse_output <= 0;
            end
        end
    end

endmodule
