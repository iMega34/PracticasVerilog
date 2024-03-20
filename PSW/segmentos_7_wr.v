
module segmentos_7_wr(
    input [7:0] switch_input,
    output [6:0] HEX0, HEX1, HEX2
);

    reg [3:0] unidades;
    reg [3:0] decenas;

    // Separación de las unidades, decenas y centenas
    always @(switch_input) begin
        // Las unidades se obtienen con el módulo 10
        unidades = switch_input % 10;
        // Las decenas se obtienen con el módulo 100 y luego se divide entre 10
        decenas = (switch_input / 10) % 10;
    end

    segmentos_7 UNIDADES(
        .switch_input(unidades),
        .display(HEX0)
    );

    segmentos_7 DECENAS(
        .switch_input(decenas),
        .display(HEX1)
    );

endmodule