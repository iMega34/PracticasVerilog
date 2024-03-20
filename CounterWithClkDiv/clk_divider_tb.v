
`timescale 1s/100ms

module clk_divider_tb ();

    reg clk;
    reg rst_n_a;
    wire clk_div;
    wire ctrl_signal;

    clk_divider #(
        .CLK_FREQ(50_000_000),
        .COUNT(2)
    ) DUT (
        .clk(clk),
        .rst_n_a(rst_n_a),
        .clk_div(clk_div),
        .ctrl_signal(ctrl_signal)
    );

    always begin
        #1 clk = ~clk;
    end

    initial begin
        clk = 1'b0;
        rst_n_a = 1'b0;
        #10;
        rst_n_a = 1'b1;
        #100;
        rst_n_a = 1'b0;
        #100;
        $Stop;
    end

endmodule


