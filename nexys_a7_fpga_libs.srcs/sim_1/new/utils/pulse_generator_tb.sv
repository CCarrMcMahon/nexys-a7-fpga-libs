`timescale 1ns / 1ps

/**
 * @module pulse_generator_tb
 * @brief Test bench for the pulse_generator module.
 *
 * This test bench instantiates the pulse_generator module and applies various input stimuli to verify its behavior.
 *
 * @designer Christopher McMahon
 * @date 12-20-2024
 */
module pulse_generator_tb;

    // Parameters for the pulse_generator instance
    parameter integer CLK_FREQ = 100_000_000;
    parameter integer PULSE_FREQ = 1_000_000;
    parameter integer DUTY_CYCLE = 10;
    parameter integer PULSE_OFFSET = 50;

    // Clock and reset signals
    logic clk;
    logic rst;

    // Enable and clear signals for pulse generation
    logic enable;
    logic clear;

    // Pulse output signal
    logic pulse_output;

    // Instantiate the pulse_generator module
    pulse_generator #(
        .CLK_FREQ(CLK_FREQ),
        .PULSE_FREQ(PULSE_FREQ),
        .DUTY_CYCLE(DUTY_CYCLE),
        .PULSE_OFFSET(PULSE_OFFSET)
    ) uut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .clear(clear),
        .pulse_output(pulse_output)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 100 MHz clock
    end

    // Test sequence
    initial begin
        // Initialize signals
        rst = 1;
        enable = 0;
        clear = 0;

        // Apply reset
        #20;
        rst = 0;

        // Enable pulse generation
        #20;
        enable = 1;

        // Wait for a few periods
        #9550;

        // Clear the pulse output
        clear = 1;
        #10;
        clear = 0;

        // Wait for a few more periods
        #5000;

        // Disable pulse generation
        enable = 0;

        // End simulation
        #100;
        $finish;
    end

    // Monitor pulse output
    initial begin
        $monitor("Time: %0t | Pulse Output: %b", $time, pulse_output);
    end

endmodule
