
module gates_wr (
    input [1:0] SW,
    output [9:0] LEDR
);

    gates GATES (
        .A(SW[0]),
        .B(SW[1]),
        .LEDR(LEDR[7:0])
    );

endmodule
