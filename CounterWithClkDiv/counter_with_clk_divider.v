
module counter_with_clk_divider(
    input MAX10_CLK1_50,
    input [9:0] SW,
    input [1:0] KEY,
    output [9:0] LEDR,
    output [6:0] HEX0, HEX1, HEX2
);

    wire clk_div_wire;
    wire [7:0] counter;

    clk_divider #(
        .COUNT(25)
    ) CLK_WRAPPER(
        .clk(MAX10_CLK1_50),
        .rst_n_a(KEY[0]),
        .ctrl_signal(LEDR[9]),
        .clk_div(clk_div_wire)
    );

    counter COUNTER_WRAPPER(
        .clk(clk_div_wire),
        .rst_n_a(KEY[0]),
        .reverse(SW[0]),
        .out_data(counter)
    );

    segmentos_7_wr DISPLAY_WRAPPER(
        .input_signal(counter),
        .HEX0(HEX0),
        .HEX1(HEX1),
        .HEX2(HEX2)
    );

endmodule
