
module UART_BaudRate_generator(
    input clk,
    input rst_n_a,
    input [15:0] baud_rate,
    output tick
);

    reg [15:0] baudRateReg;

    always @(posedge clk or negedge rst_n_a)
        if (!rst_n_a) baudRateReg <= 16'b1;
        else if (tick) baudRateReg <= 16'b1;
            else baudRateReg <= baudRateReg + 1'b1;

    assign tick = (baudRateReg == baud_rate);

endmodule

