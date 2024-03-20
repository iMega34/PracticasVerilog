
module UART_rs232_tx (
	input clk, rst_n_a,
	input transmitter_enable,
	input [7:0] transmitter_data,
	output reg transmitter_done,
	output reg transmitter_port,
	input tick,
	input bits
);

	parameter IDLE = 1'b0, WRITE = 1'b1;

	reg STATE, NEXT;
	reg write_enable = 1'b0;
	reg start_bit = 1'b1;
	reg stop_bit = 1'b0;
	reg [4:0] bit = 5'b00000;
	reg [3:0] counter = 4'b0000;
	reg [7:0] in_data = 8'b00000000;
	reg [1:0] R_edge;
	wire D_edge;

	always @ (posedge clk or negedge rst_n_a) begin
		if(!rst_n_a)
			R_edge <= 2'b00;
		else
			R_edge <={R_edge[0], transmitter_enable};
	end

	always @ (posedge clk or negedge rst_n_a) begin
		if (!rst_n_a) STATE <= IDLE;
		else STATE <= NEXT;
	end

	always @ (STATE or D_edge or transmitter_data or transmitter_done) begin
		case(STATE)
			IDLE:
				if(D_edge)
					NEXT = WRITE;
				else
					NEXT = IDLE;
			WRITE:
				if(transmitter_done)
					NEXT = IDLE;
				else
					NEXT = WRITE;
			default:
				NEXT = IDLE;
		endcase
	end

	always @ (STATE) begin
		case (STATE)
			WRITE:
				write_enable <= 1'b1;
			IDLE:
				write_enable <= 1'b0;
		endcase
	end

	always @ (posedge tick) begin
		if (!write_enable) begin
			transmitter_done = 1'b0;
			start_bit <= 1'b1;
			stop_bit <= 1'b0;
		end else if (write_enable) begin
			counter <= counter + 1;

			if (start_bit & !stop_bit) begin
				transmitter_port <=1'b0;
				in_data <= transmitter_data;
			end

			if ((counter == 4'b1111) & (start_bit)) begin
				start_bit <= 1'b0;
				in_data <= {1'b0, in_data[7:1]};
				transmitter_port <= in_data[0];
			end

			if ((counter == 4'b1111) & (!start_bit) &  (bit < bits - 1)) begin
				in_data <= {1'b0, in_data[7:1]};
				transmitter_port <= in_data[0];
				start_bit <= 1'b0;
				counter <= 4'b0000;
				bit <= bit + 1;
			end

			if ((counter == 4'b1111) & (bit == bits - 1) & (!stop_bit)) begin
				transmitter_port <= 1'b1;
				counter <= 4'b0000;
				stop_bit <=1'b1;
			end

			if ((counter == 4'b1111) & (bit == bits - 1) & (stop_bit) ) begin
				bit <= 4'b0000;
				transmitter_done <= 1'b1;
				counter <= 4'b0000;
			end
		end
	end

	assign D_edge = !R_edge[1] & R_edge[0];

endmodule
