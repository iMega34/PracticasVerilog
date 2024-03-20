
/*
Contador simple que cuenta hasta un valor máximo y luego vuelve a cero.

Parámetros:
    C_MAX: Valor máximo al que cuenta el contador. Por defecto, 1,000,000

Entradas:
    clk: Reloj del sistema.
    rst_n_a: Reset asíncrono activo bajo.

Salidas:
    out_data: Valor del contador.
*/
module counter #(parameter C_MAX = 1_000_000) (
    input clk, rst_n_a,
    output reg [$clog2(C_MAX) - 1:0] out_data
);

    // Función de conteo sensible al flanco de subida del reloj
    // y al reset asíncrono
    always @(posedge clk or negedge rst_n_a) begin
        // Si el reset está activo, el contador se pone a cero
        if (!rst_n_a)
            out_data <= 0;
        else begin
            // Si el contador llega al valor máximo, se pone a cero
            if (out_data > C_MAX)
                out_data <= 0;
            // En caso contrario, se incrementa en uno
            else
                out_data <= out_data + 1;
        end
    end

endmodule
