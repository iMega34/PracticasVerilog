
module FSM_PSW_wr (
    input MAX10_CLK1_50,
    input [1:0] KEY,
    input [3:0] SW,
    output [9:0] LEDR,
    output [6:0] HEX0, HEX1
);

    wire clk_div_wire;

    clk_divider #(
        .COUNT(10)
    ) CLK_WRAPPER(
        .clk(MAX10_CLK1_50),
        .rst_n_a(KEY[0]),
        .ctrl_signal(LEDR[9]),
        .clk_div(clk_div_wire)
    );

    FSM_PSW #(
        .PW_D1(7),
        .PW_D2(1),
        .PW_D3(1),
        .PW_D4(7)
    ) FSM_PSW_WRAPPER(
        .clk(clk_div_wire),
        .rst_n_a(KEY[0]),
        .enable(KEY[1]),
        .input_psw(SW),
        .psw_output(LEDR[1:0])
    );

    segmentos_7_wr DISPLAY_WRAPPER(
        .switch_input(SW),
        .HEX0(HEX0),
        .HEX1(HEX1)
    );

endmodule
