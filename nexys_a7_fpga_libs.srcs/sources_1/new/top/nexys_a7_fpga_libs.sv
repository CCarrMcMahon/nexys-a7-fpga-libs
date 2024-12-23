module nexys_a7_fpga_libs (
    input logic clk100mhz,
    input logic cpu_resetn,
    input logic btnc,
    input logic [0:0] sw,
    output logic [4:0] ja
);

    // Parameters for the clock_generator instance
    localparam real ClkInFreq = 100_000_000;
    localparam real ClockOutFreq = 0.36;
    localparam real PhaseShift = 38.4;
    localparam real DutyCycle = 12.75;
    localparam logic IdleValue = 0;

    // Signals for the clock_generator instance
    logic clear;
    logic enable;
    logic clk_out;

    // Instantiate the clock_generator module
    clock_generator #(
        .CLK_IN_FREQ (ClkInFreq),
        .CLK_OUT_FREQ(ClockOutFreq),
        .PHASE_SHIFT (PhaseShift),
        .DUTY_CYCLE  (DutyCycle),
        .IDLE_VALUE  (IdleValue)
    ) clk_gen (
        .clk(clk100mhz),
        .rst(~cpu_resetn),
        .clear(clear),
        .enable(enable),
        .clk_out(clk_out)
    );

    // Assign the clock generator signals
    assign clear = btnc;
    assign enable = sw[0];
    assign ja = {clk_out, enable, clear, clk100mhz, cpu_resetn};

endmodule
