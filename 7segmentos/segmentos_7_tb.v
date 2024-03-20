
// Iniciar escala de tiempo del módulo
`timescale 1ns / 100ps

module segmentos_7_tb();

	reg [7:0] seg7_tb_in;
	wire [6:0] seg7_tb_out;

	// Instanciamos el módulo al TB
	segmentos_7 DUT (
		.data_segmentos_in(seg7_tb_in),
		.data_segmentos_out(seg7_tb_out)
	);

	// Simulación
	initial begin
		seg7_tb_in = 8'b00000000;
		#10
		seg7_tb_in = 8'b0;
		#10
		seg7_tb_in = 8'b00000001;
		#10
		seg7_tb_in = 8'b0;
		#10
		seg7_tb_in = 8'b00000101;
		#10
		seg7_tb_in = 8'b0;
		#10
		seg7_tb_in = 8'b00001001;
		#10
		seg7_tb_in = 8'b0;
		$Stop;
	end

endmodule


