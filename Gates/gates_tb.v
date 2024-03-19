
`timescale 1ns/100ps

module gates_tb ();

    reg A_tb;
    reg B_tb;

    gates GATES_TB (
        .A(A_tb),
        .B(B_tb),
        .LEDR(LEDR_tb)
    );

    initial begin
        A_tb = 1'b0;
        B_tb = 1'b0;
        #10;
        A_tb = 1'b0;
        B_tb = 1'b1;
        #10;
        A_tb = 1'b1;
        B_tb = 1'b0;
        #10;
        A_tb = 1'b1;
        B_tb = 1'b1;
        #10;
        $Stop;
    end

endmodule
