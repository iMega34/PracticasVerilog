
`timescale 1s/100ms

module UART_tb ();

	reg MAX10_CLK1_50;
	reg [7:0] SW;
	reg [1:0] KEY;
	wire [35:0] GPIO;
	wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

	UART DUT (
		.MAX10_CLK1_50(MAX10_CLK1_50),
		.SW(SW),
		.KEY(KEY),
		.GPIO(GPIO),
		.HEX0(HEX0),
		.HEX1(HEX1),
		.HEX2(HEX2),
		.HEX3(HEX3),
		.HEX4(HEX4),
		.HEX5(HEX5)
	);

	// Clock generation
	always #5 MAX10_CLK1_50 = ~MAX10_CLK1_50;

	// Test stimulus
	initial begin
		// Initialize inputs
		SW = 8'h00;
		KEY = 2'b00;

		// Wait for a few clock cycles
		#10;

		// Test case 1: Transmit data
		SW = 8'hFF;
		#10;

		// Test case 2: Receive data
		SW = 8'h00;
		#10;

		// Test case 3: Transmit and receive data simultaneously
		SW = 8'hAA;
		#10;

		// End simulation
		$Stop;
	end

endmodule