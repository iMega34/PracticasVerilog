
/*
Divisor de frecuencia de reloj.

Parámetros:
    CLK_FREQ: Frecuencia del reloj de entrada. Por defecto, 50 MHz.
    SPEED: Velocidad de conteo. Por defecto, 2. La velocidad de conteo
    es el número entre el cual se divide la frecuencia del reloj de entrada.
    Por ejemplo, si la frecuencia del reloj de entrada es de 50 MHz y la
    velocidad de conteo es de 2, la frecuencia del reloj de salida será de
    25 MHz.

Entradas:
    clk: Reloj de entrada.
    rst_n_a: Reset asíncrono activo bajo.

Salidas:
    clk_div: Reloj de salida.
*/
module clk_divider (
    input clk, rst_n_a,
    output wire clk_div,
    output wire ctrl_signal
);

    reg [16:0] counter;

    always @(posedge clk or negedge rst_n_a) begin
        if (!rst_n_a)
            counter <= 0;
        else
            counter <= counter + 1;
    end

    assign clk_div = counter[0];
    assign ctrl_signal = counter[0];

endmodule
