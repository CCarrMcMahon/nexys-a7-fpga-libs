`timescale 1ns / 1ps

module nexys_a7_fpga_libs (
    input logic clk100mhz,
    input logic cpu_resetn,
    input logic [15:0] sw,
    output logic [15:0] led
);

    logic [31:0] counter;
    logic slow_clk;

    // Clock divider to create a slower clock
    always_ff @(posedge clk100mhz or negedge cpu_resetn) begin
        if (!cpu_resetn) begin
            counter  <= 32'd0;
            slow_clk <= 1'b0;
        end else begin
            // Divide 100 MHz clock by 5 million and toggle the output to get a 10 Hz clock
            if (counter == 32'd5_000_000 - 1) begin
                counter  <= 32'd0;
                slow_clk <= ~slow_clk;
            end else begin
                counter <= counter + 1;
            end
        end
    end

    // LED control logic
    always_ff @(posedge slow_clk or negedge cpu_resetn) begin
        if (!cpu_resetn) begin
            led <= 16'b0;
        end else begin
            led <= sw;
        end
    end

endmodule
