
/*
Práctica 2 - Display de 7 segmentos
Autor: Erick Daniel Ortiz Cervantes
Diseño con lógica programable
Entradas:
	Bus de 4 datos: datas_segmentos_int
Salidas:
	Bus de 7 datos: segmentos_out
*/

module segmentos_7(
	input [7:0] data_segmentos_in,
	output reg [6:0] data_segmentos_out
);

always @(*)
begin
	case(data_segmentos_in)
		0:
			data_segmentos_out = 7'h40;
		1:
			data_segmentos_out = 7'h79;
		2:
			data_segmentos_out = 7'h24;
		3:
			data_segmentos_out = 7'h30;
		4:
			data_segmentos_out = 7'h19;
		5:
			data_segmentos_out = 7'h12;
		6:
			data_segmentos_out = 7'h02;
		7:
			data_segmentos_out = 7'h78;
		8:
			data_segmentos_out = 7'h00;
		9:
			data_segmentos_out = 7'h18;
		default:
			data_segmentos_out = 7'h7E;
	endcase
end
	
endmodule
