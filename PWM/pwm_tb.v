
`timescale 1ms/100ns

module pwm_tb;

    reg MAX10_CLK1_50;
    reg [1:0] KEY;
    reg [9:0] SW;
    wire [6:0] HEX0, HEX1, HEX2;
    wire [9:0] GPIO;

    reg CLK;

    PWM #(
        .CLK_FREQ(50_000_000),
        .DUTY_FREQ(50)
    ) dut (
        .MAX10_CLK1_50(MAX10_CLK1_50),
        .KEY(KEY),
        .SW(SW),
        .HEX0(HEX0),
        .HEX1(HEX1),
        .HEX2(HEX2),
        .GPIO(GPIO)
    );

    always begin
        #5 CLK = ~CLK; 
    end

    always begin
        #2 MAX10_CLK1_50 = CLK; 
    end

    initial begin
        CLK = 0; 
        KEY = 2'b00; 
        SW = 10'b0000000000; 

        #10 KEY = 2'b01;
        #10 SW = 10'b0101010101;
        #10 SW = 10'b1010101010;
        #10 KEY = 2'b10;
        #10 SW = 10'b1100110011;
        #10 KEY = 2'b00;
        #10;
        $Stop;
    end

endmodule
