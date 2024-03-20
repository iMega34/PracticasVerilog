

module segmentos_7_wr(
	input [7:0] SW,
	output [6:0] HEX0, HEX1, HEX2
);

	reg [3:0] unidades;
	reg [3:0] decenas;
	reg [2:0] centenas;

   always @(SW) begin
      unidades = SW % 10;
		decenas = (SW / 10) % 10;
		centenas = (SW / 100) % 100;
   end

  // Convertir a código de 7 segmentos
  segmentos_7 UNIDADES(
		.data_segmentos_in(unidades),
		.data_segmentos_out(HEX0)
  );

  segmentos_7 DECENAS(
		.data_segmentos_in(decenas),
		.data_segmentos_out(HEX1)
  );

  segmentos_7 CENTENAS(
		.data_segmentos_in(centenas),
		.data_segmentos_out(HEX2)
  );

endmodule