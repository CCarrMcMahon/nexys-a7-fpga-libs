`timescale 1ns / 1ps

module nexys_a7_fpga_template_tb;
    // Inputs
    logic clk100mhz;
    logic cpu_resetn;
    logic [15:0] sw;

    // Outputs
    logic [15:0] led;

    // Instantiate the Unit Under Test (UUT)
    nexys_a7_fpga_template uut (
        .clk100mhz(clk100mhz),
        .cpu_resetn(cpu_resetn),
        .sw(sw),
        .led(led)
    );

    // Generate the 100 MHz clock
    initial begin
        clk100mhz = 0;
        forever #5 clk100mhz = ~clk100mhz;  // 10 ns period -> 100 MHz
    end

    // Simulation sequence
    initial begin
        // Initialize Inputs
        cpu_resetn = 0;
        sw = 16'h0000;

        // Wait 100 ns for global reset to finish
        #100;
        cpu_resetn = 1;

        // Apply test stimulus
        #1_000_000;
        sw = 16'hAAAA;  // Pattern 1010101010101010
        #200_000_000;  // Wait for a considerable time (200 ms)

        #1_000_000;
        sw = 16'h5555;  // Pattern 0101010101010101
        #200_000_000;  // Wait for a considerable time (200 ms)

        // Finish simulation
        #200;
        $finish;
    end
endmodule
