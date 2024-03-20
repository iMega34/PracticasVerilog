
module segmentos_7_wr(
    input [7:0] input_signal,
    output [6:0] HEX0, HEX1, HEX2
);

    reg [3:0] unidades;
    reg [3:0] decenas;
    reg [3:0] centenas;

    // Separación de las unidades, decenas y centenas
    always @(input_signal) begin
        // Las unidades se obtienen con el módulo 10
        unidades = input_signal % 10;
        // Las decenas se obtienen con el módulo 100 y luego se divide entre 10
        decenas = (input_signal / 10) % 10;
        // Las centenas se obtienen con el módulo 1000 y luego se divide entre 100
        centenas = (input_signal / 100) % 10;
    end

    segmentos_7 UNIDADES(
        .switch_input(unidades),
        .display(HEX0)
    );

    segmentos_7 DECENAS(
        .switch_input(decenas),
        .display(HEX1)
    );

    segmentos_7 CENTENAS(
        .switch_input(centenas),
        .display(HEX2)
    );

endmodule