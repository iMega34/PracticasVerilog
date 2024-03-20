
module UART(
	input MAX10_CLK1_50,
	input [7:0] SW,
	input [1:0] KEY,
	inout [35:0] GPIO,
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);

	reg [7:0] data_to_transmit;
	wire [7:0] data_to_receive;

	reg [3:0] unidades_receptor;
	reg [3:0] decenas_receptor;
	reg [2:0] centenas_receptor;

	reg [3:0] unidades_transmisor;
	reg [3:0] decenas_transmisor;
	reg [2:0] centenas_transmisor;

	// Asignación de la entrada del transmisor
	always @(SW) begin
		unidades_transmisor = SW % 10;
		decenas_transmisor = (SW / 10) % 10;
		centenas_transmisor = (SW / 100) % 100;
	end

	// Asignación de la entrada del receptor
	always @(data_to_receive) begin
		unidades_receptor = data_to_receive % 10;
		decenas_receptor = (data_to_receive / 10) % 10;
		centenas_receptor = (data_to_receive / 100) % 100;
	end

	// Asignación de las salidas del receptor
	always @(posedge MAX10_CLK1_50) data_to_transmit = SW;

	TOP TRANSMITTER (
		.clk(MAX10_CLK1_50),
		.rst_n_a(KEY[0]),
		.receiver_port(),
		.receiver_data(),
		.transmitter_port(GPIO[0]),
		.transmitter_data(data_to_transmit)
	);

	segmentos_7 UNIDADES_TRANSMISOR(
		.input_signal(unidades_transmisor),
		.display(HEX3)
	);

	segmentos_7 DECENAS_TRANSMISOR(
		.input_signal(decenas_transmisor),
		.display(HEX4)
	);

	segmentos_7 CENTENAS_TRANSMISOR(
		.input_signal(centenas_receptor),
		.display(HEX5)
	);

	TOP RECEPTOR (
		.clk(MAX10_CLK1_50),
		.rst_n_a(KEY[0]),
		.receiver_port(GPIO[1]),
		.receiver_data(data_to_receive),
		.transmitter_port(),
		.transmitter_data()
	);

	segmentos_7 UNIDADES_RECEPTOR(
		.input_signal(unidades_receptor),
		.display(HEX0)
	);

	segmentos_7 DECENAS_RECEPTOR(
		.input_signal(decenas_receptor),
		.display(HEX1)
	);

	segmentos_7 CENTENAS_RECEPTOR(
		.input_signal(centenas_receptor),
		.display(HEX2)
	);

endmodule
