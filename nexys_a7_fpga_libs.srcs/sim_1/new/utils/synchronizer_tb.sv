`timescale 1ns / 1ps

/**
 * @module synchronizer_tb
 * @brief Test bench for the synchronizer module.
 *
 * This test bench instantiates the synchronizer module and applies various input stimuli to verify its behavior.
 *
 * @designer Christopher McMahon
 * @date 12-20-2024
 */
module synchronizer_tb;

    // Parameters for the synchronizer instance
    parameter integer STAGES = 2;

    // Clock and reset signals
    logic clk;
    logic rst;

    // Asynchronous input signal
    logic async_signal;

    // Synchronized output signal
    logic sync_signal;

    // Instantiate the synchronizer module
    synchronizer #(
        .STAGES(STAGES)
    ) uut (
        .clk(clk),
        .rst(rst),
        .async_signal(async_signal),
        .sync_signal(sync_signal)
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
        async_signal = 0;

        // Apply reset
        #20;
        rst = 0;

        // Apply asynchronous signal
        #30;
        async_signal = 1;
        #10;
        async_signal = 0;

        // Wait for a few clock cycles
        #100;

        // Apply asynchronous signal again
        async_signal = 1;
        #10;
        async_signal = 0;

        // Wait for a few more clock cycles
        #100;

        // End simulation
        $finish;
    end

    // Monitor synchronized output
    initial begin
        $monitor("Time: %0t | Async Signal: %b | Sync Signal: %b", $time, async_signal, sync_signal);
    end

endmodule
