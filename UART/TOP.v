
module TOP(
	input clk,
	input rst_n_a,
	input receiver_port,
	input [7:0] transmitter_data,
	output transmitter_port,
	output [7:0] receiver_data
);

	wire receiver_done;
	wire TxDone;
	wire tick;
	wire transmitter_enable;
	wire receiver_enable;
	wire [3:0] bits;
	wire [15:0] BaudRate;

	assign receiver_enable = 1'b1;
	assign transmitter_enable = 1'b1;
	assign BaudRate = 16'd325;
	assign bits = 4'b1000	;

	UART_rs232_rx I_RS232RX(
		.clk(clk),
		.rst_n_a(rst_n_a),
		.receiver_enable(receiver_enable),
		.receiver_data(receiver_data),
		.receiver_done(receiver_done),
		.receiver_port(receiver_port),
		.tick(tick),
		.bits(bits)
	);

	UART_rs232_tx I_RS232TX(
		.clk(clk),
		.rst_n_a(rst_n_a),
		.transmitter_enable(transmitter_enable),
		.transmitter_data(transmitter_data),
		.transmitter_done(TxDone),
		.transmitter_port(transmitter_port),
		.tick(tick),
		.bits(bits)
	);

	UART_BaudRate_generator I_BAUDGEN(
		.clk(clk),
		.rst_n_a(rst_n_a),
		.tick(tick),
		.baud_rate(BaudRate)
	);

endmodule
