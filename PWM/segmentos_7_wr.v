
module segmentos_7_wr(
    input [7:0] SW,
    output [6:0] HEX0, HEX1, HEX2
);

    reg [3:0] unidades;
    reg [3:0] decenas;
    reg [2:0] centenas;

    // Separación de las unidades, decenas y centenas
    always @(SW) begin
        // Las unidades se obtienen con el módulo 10
        unidades = SW % 10;
        // Las decenas se obtienen con el módulo 100 y luego se divide entre 10
        decenas = (SW / 10) % 10;
        // Las centenas se obtienen con el módulo 1000 y luego se divide entre 100
        centenas = (SW / 100) % 100;
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