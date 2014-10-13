/* -----------------------------------------
	VGA control unit
----------------------------------------- */ 
module camera_control 
(
	// Input
	input reset_n,
	input clk_25,
	input pclk,
	input [7:0] data_in,
	input h_ref,
	input v_sync,
	// Output
	output reset,
	output xclk,
	output reg hs,
	output vs,
	output reg [2:0] data_out
);

	/* -----------------------------------------
		Paramters
	----------------------------------------- */ 
	parameter divider = 64;
	
	/* -----------------------------------------
		Registers
	----------------------------------------- */
	reg [18:0] h_count;
	reg [18:0] v_count;
	reg byte_nr;

	/* -----------------------------------------
		Behavioural
	----------------------------------------- */ 
	assign reset = reset_n;
	assign xclk = clk_25;
	assign vs = ~v_sync;
	
	always @ (posedge clk_25 or negedge reset_n) begin	
		if (!reset_n) begin
			h_count <= 0;
			v_count <= 0;
			byte_nr <= 0;
		end else begin
			if (v_sync) begin
				v_count <= 0;
				h_count <= 0;
				byte_nr <= 0;
			end else begin
			
				hs <= 1;
			
				if (v_count >= (13328 - 80 - 45) && v_count <= (13328 - 45)) begin
					// Send sync pulse
					hs <= 0;
				// After the back porch and before the front porch
				end else if (v_count >= 13328 && v_count <= (13328 + 376320)) begin
					if (!h_ref) begin
						// Not valid data
						if (h_count >= 19 && h_count <= (19 + 80)) begin
							hs <= 0;
						end
					end else begin
						if (byte_nr) begin
							// Valid data
							if (data_in >= 0 && data_in <= divider-1) 
								data_out <= 3'b001; // 2'b11; // BLUE
							else if (data_in >= divider && data_in <= divider*2-1) 
								data_out <= 3'b101; // 2'b10; // PURPLE
							if (data_in >= divider*2 && data_in <= divider*3-1)
								data_out <= 3'b011; // 2'b01; // L_BLUE
							else
								data_out <= 3'b111; // 2'b00; // WHITE
						end else
							data_out <= 3'b111; // 2'b00; // WHITE
						byte_nr <= byte_nr + 1;
						h_count <= 0;
					end
				end 
				v_count <= v_count + 1;
			end
		end
	end
endmodule