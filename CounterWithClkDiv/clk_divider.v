
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
module clk_divider #(
    parameter CLK_FREQ = 50_000_000,
    parameter COUNT = 2
) (
    input clk, rst_n_a,
    output reg clk_div,
    output reg ctrl_signal
);

    localparam output_freq = CLK_FREQ / COUNT;
    reg [31:0] count;

    // Función de conteo sensible al flanco de subida del reloj
    // y al reset asíncrono
    always @(posedge clk or negedge rst_n_a) begin
        // Si el reset está activo, el contador se pone a cero y se emite
        // un pulso de reloj bajo
        if (!rst_n_a == 1'b1) begin
            count <= 32'b0;
            clk_div <= 1'b0;
            ctrl_signal <= 1'b0;
        end
        // Si el contador llega al valor de conteo, se pone a cero y se emite
        // un pulso de reloj contrario al actual
        else if (count == output_freq - 1) begin
            count <= 32'b0;
            clk_div <= ~clk_div;
            ctrl_signal <= ~ctrl_signal;
        end
        // En caso contrario, se incrementa en uno y se mantiene el pulso de
        // reloj en alto
        else begin
            count <= count + 1;
            clk_div <= clk_div;
            ctrl_signal <= ctrl_signal;
        end
    end

endmodule
