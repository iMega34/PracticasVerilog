
module UART_rs232_rx (
	input clk, rst_n_a,
	inout receiver_enable,
	output reg [7:0] receiver_data,
	output reg receiver_done,
	input receiver_port,
	input tick,
	input [3:0] bits
);

	parameter IDLE = 1'b0, READ = 1'b1;

	reg STATE, NEXT;
	reg read_enable = 1'b0;
	reg start_bit = 1'b1;
	reg [4:0] bit = 5'b00000;
	reg [3:0] counter = 4'b0000;
	reg [7:0] read_data = 8'b00000000;

	always @ (posedge clk or negedge rst_n_a) begin
		if (!rst_n_a)
			STATE <= IDLE;
		else
			STATE <= NEXT;
	end

	always @ (STATE or receiver_data or receiver_enable or receiver_done) begin
		case(STATE)
			IDLE:
				if (!receiver_data & receiver_enable)
					NEXT = READ;
				else
					NEXT = IDLE;
			READ:
				if (receiver_done)
					NEXT = IDLE;
				else
					NEXT = READ;
			default:
				NEXT = IDLE;
		endcase
	end

	always @ (STATE or receiver_done) begin
		case (STATE)
			READ:
				read_enable <= 1'b1;
			IDLE:
				read_enable <= 1'b0;
		endcase
	end

	always @ (posedge tick) begin
		if (read_enable) begin
			receiver_done <= 1'b0;
			counter <= counter + 1;
			if ((counter == 4'b1000) & (start_bit)) begin
				start_bit <= 1'b0;
				counter <= 4'b0000;
			end
			if ((counter == 4'b1111) & (!start_bit) & (bit < bits)) begin
				bit <= bit + 1;
				read_data <= {receiver_data, read_data[7:1]};
				counter <= 4'b0000;
			end
			if ((counter == 4'b1111) & (bit == bits) & (receiver_port)) begin
				bit <= 4'b0000;
				receiver_done <= 1'b1;
				counter <= 4'b0000;
				start_bit <= 1'b1;
			end
		end
	end

	always @ (posedge clk) begin
		if (bits == 4'b1000)
			receiver_data[7:0] <= read_data[7:0];
		if (bits == 4'b0111)
			receiver_data[7:0] <= {1'b0, read_data[7:1]};
		if (bits == 4'b0110)
			receiver_data[7:0] <= {1'b0, 1'b0, read_data[7:2]};
	end

endmodule
