module sccb 
(
	input reset_n,
	input clk_24,
	input en,
	
	output sio_c,
	output sio_d
);

	parameter input_clk = 24_000_000;
	parameter bus_clk = 400_000;
	parameter divider = (input_clk/bus_clk/4);

	reg [5:0] counter; // divider*4 = 60 => 2^6
	reg stretch;
	reg s_clk;
	reg d_clk;
	reg sio_c_en;
	reg data;

	// Generate SIO_C DATA_C at 400kHz
	always @ (posedge clk_24 or negedge reset_n) begin
		if (!reset_n) begin
			counter <= 0;
			stretch <= 0;
		end else begin
			if (counter == divider*4-1)
				counter <= 0;
			else if (stretch == 0)
				counter <= counter + 1;
			if (counter >= 0 && counter <= divider*1-1) begin
				s_clk <= 0;
				d_clk <= 0;
			end else if (counter >= divider && counter <= divider*2-1) begin
				s_clk <= 0;
				d_clk <= 1;
			end else if (counter >= divider*2 && counter <= divider*3-1) begin
				s_clk <= 1;
				d_clk <= 1;
			end else begin
				s_clk <= 1;
				d_clk <= 0;
			end 	
		end
	end
	
	parameter start = 0, command = 1;
	reg state, next_state;
	
	always @ (posedge d_clk) begin
		if (!reset_n) begin
			sio_c_en <= 0;
		end else begin
			case (state)
				start:
					if (en) begin
						sio_c_en <= 1;
						next_state <= data;
					end else
						sio_c_en <= 0;
				command:
					next_state <= command;
			endcase
		end
	end
	
	always @ (negedge d_clk) begin
		if (!reset_n) begin
			state <= start;
			data <= 0;
		end else begin
			case (state)
				start:
					if (en)
						next_state <= data;
				command:
					data <= 1;
			endcase
		end
	end
	
	assign sio_c = sio_c_en ? s_clk : 0;
	assign sio_d = data;
endmodule