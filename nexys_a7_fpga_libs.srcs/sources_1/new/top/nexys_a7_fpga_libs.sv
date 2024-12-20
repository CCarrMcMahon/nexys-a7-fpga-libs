module nexys_a7_fpga_libs (
    input logic clk100mhz,
    input logic cpu_resetn,
    input logic [15:0] sw,
    output logic [15:0] led,
    output logic [0:0] ja
);

    // Parameters for the pulse_generator instance
    localparam integer ClkFreq = 100_000_000;
    localparam integer PulseFreq = 10;  // 10 Hz pulse frequency
    localparam integer DutyCycle = 50;  // 50% duty cycle
    localparam integer PulseOffset = 0;

    // Signals for the pulse_generator instance
    logic enable;
    logic clear;
    logic pulse_output;

    // Instantiate the pulse_generator module
    pulse_generator #(
        .CLK_FREQ(ClkFreq),
        .PULSE_FREQ(PulseFreq),
        .DUTY_CYCLE(DutyCycle),
        .PULSE_OFFSET(PulseOffset)
    ) pulse_gen (
        .clk(clk100mhz),
        .rst(~cpu_resetn),
        .enable(enable),
        .clear(clear),
        .pulse_output(pulse_output)
    );

    // LED control logic
    always_ff @(posedge pulse_output or negedge cpu_resetn) begin
        if (!cpu_resetn) begin
            led <= 16'b0;
        end else begin
            led <= sw;
        end
    end

    // Enable the pulse generator
    assign enable = 1;
    assign clear = 0;

    // Visualize the pulse output on the JA header
    assign ja = pulse_output;

endmodule
