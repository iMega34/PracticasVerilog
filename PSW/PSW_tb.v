
`timescale 1ns/100ps

module PSW_tb ();

    reg MAX10_CLK1_50;
    reg [1:0] KEY;
    reg [3:0] SW;
    wire [9:0] LEDR;
    wire [6:0] HEX0, HEX1;

    FSM_PSW_wr DUT (
        .MAX10_CLK1_50(MAX10_CLK1_50),
        .KEY(KEY),
        .SW(SW),
        .LEDR(LEDR),
        .HEX0(HEX0),
        .HEX1(HEX1)
    );

    initial begin
        MAX10_CLK1_50 = 0;
        KEY = 0;
        SW = 0;

        #10 KEY = 1;
        #5 KEY = 0;

        #10 SW = 7;
        #10 KEY = 1;
        #5 KEY = 0;

        #10 SW = 1;
        #10 KEY = 1;
        #5 KEY = 0;

        #10 SW = 1;
        #10 KEY = 1;
        #5 KEY = 0;

        #10 SW = 7;
        #10 KEY = 1;
        #5 KEY = 0;

        #100 $Stop;
    end

    always #5 MAX10_CLK1_50 = ~MAX10_CLK1_50;

endmodule


