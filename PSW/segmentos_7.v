
/*
Controlador de display de 7 segmentos

Convierte la entrada binaria de los switches de la FPGA a un valor de 0 a 9

Entradas:
    switch_input: Valor de los switches de la FPGA.

Salidas:
    data_segmentos_out: Valor de los segmentos del display de 7 segmentos.
*/
module segmentos_7(
    input [7:0] switch_input,
    output reg [6:0] display
);

    // Asignación de los valores de los segmentos del display de 7 segmentos
    always @(*) begin
        case(switch_input)
            0:
                display = 7'h40;
            1:
                display = 7'h79;
            2:
                display = 7'h24;
            3:
                display = 7'h30;
            4:
                display = 7'h19;
            5:
                display = 7'h12;
            6:
                display = 7'h02;
            7:
                display = 7'h78;
            8:
                display = 7'h00;
            9:
                display = 7'h18;
            default:
                display = 7'h7E;
        endcase
    end

endmodule
