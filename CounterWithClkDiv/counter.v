
/*
Contador simple que cuenta hasta un valor máximo y luego vuelve a cero.

Parámetros:
    C_MAX: Valor máximo al que cuenta el contador. Por defecto, 256.

Entradas:
    clk: Reloj del sistema.
    rst_n_a: Reset asíncrono activo bajo.
    reverse: Bandera que indica si el contador cuenta hacia atrás.

Salidas:
    out_data: Contador.
*/
module counter #(parameter C_MAX = 256) (
    input clk, rst_n_a,
    input reverse,
    output reg [$clog2(C_MAX) - 1:0] out_data
);

    // Función de conteo sensible al flanco de subida del reloj
    // y al reset asíncrono
    always @(posedge clk or negedge rst_n_a) begin
        // Si el reset está activo, el contador se pone a cero
        if (!rst_n_a)
            out_data <= 0;
        else begin
            // Si la bandera de conteo hacia atrás está activa, se decrementa
            // el contador
            if (reverse) begin
                // Si el contador llega a cero, se asigna el valor máximo
                if (out_data < 0)
                    out_data <= 32'b1;
                // En caso contrario, se decrementa en uno
                else
                    out_data <= out_data - 1;
            end
            else begin
                // Si el contador llega al valor máximo, se pone a cero
                if (out_data > C_MAX)
                    out_data <= 0;
                // En caso contrario, se incrementa en uno
                else
                    out_data <= out_data + 1;
            end
        end
    end

endmodule
