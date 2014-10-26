/* -----------------------------------------
	VGA control unit
----------------------------------------- */ 
module vga_control 
(
	// Input
	input reset_n,
	input clk_25,
	// Output
	output reg h_sync,
	output reg v_sync,
	output reg [9:0] h_count,
	output reg [9:0] v_count,
	output reg bright
);

	/* -----------------------------------------
		Behavioural
	----------------------------------------- */ 
	always @ (posedge clk_25 or negedge reset_n) begin	
		if (!reset_n) begin
			h_sync <= 1'b1;
			v_sync <= 1'b1;
			h_count = 10'b0000000000;
			v_count = 10'b0000000000;
			bright <= 1'b0;
		end else begin
		
			// Horisontal counter
			if (h_count == 800) begin
				h_count <= 10'b0000000000;
				v_count <= v_count + 10'b1;
			end else 
				h_count <= h_count + 10'b1;
				
			// Vertical counter
			if (v_count == 521)
				v_count <= 10'b000000000;
		
			// Generate horisontal syncronization pulse
			if (h_count >= 16 && h_count < (16 + 96))
				h_sync <= 1'b0;
			else 
				h_sync <= 1'b1;
			
			// Generate vertical syncronization pulse
			if (v_count >= 10 && v_count < (10 + 2))
				v_sync <= 1'b0;
			else
				v_sync <= 1'b1;
			
			// Generate bright signal IMPORTANT! modified for 160x120
			if ((h_count >= (16 + 96 + 48 + 240) && h_count < (800 - 240)) && (v_count >= (10 + 2 + 29 + 180) && v_count < (521 - 180)))
				bright <= 1'b1;
			else 
				bright <= 1'b0;
		end
	end
endmodule