
module NERP_demo_top(
	input wire MAX10_CLK1_50,								//master clock = 50MHz
	input wire [1:0] KEY,									//right-most pushbutton for reset
	output wire [3:0] VGA_R,								//red vga output - 4 bits
	output wire [3:0] VGA_G,    							//green vga output - 4 bits
	output wire [3:0] VGA_B,	    						//blue vga output - 4 bits
	output wire VGA_HS,										//horizontal sync out
	output wire VGA_VS,										//vertical sync out
	output wire [9:0] LEDR
	);

	// VGA display clock interconnect
	wire w_clk_div;

	clk_divider CLK_DIVIDER_WRAPPER (
		.clk(MAX10_CLK1_50),
		.rst_n_a(KEY[0]),
		.ctrl_signal(LEDR[0]),
		.clk_div(w_clk_div)
	);

	vga640x480 CGA_WRAPPER (
		.clk(w_clk_div),
		.rst_n_a(KEY[0]),
		.hsync(VGA_HS),
		.vsync(VGA_VS),
		.red(VGA_R),
		.green(VGA_G),
		.blue(VGA_B)
	);

endmodule
