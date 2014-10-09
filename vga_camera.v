/* -----------------------------------------
	VGA Camera 0.3 Mp
----------------------------------------- */ 
module vga_camera 
(
	reset,
	reset_n,
	clk_25,
	xclk,
	pclk,
	data_in,
	data_out,
	h_ref,
	h_sync,
	v_sync
	
);

	/* -----------------------------------------
		Inputs/Outputs
	----------------------------------------- */ 
	input reset_n;
	input clk_25;
	input pclk;
	input [7:0] data_in;
	input h_ref;
	input v_sync;
	
	output h_sync;
	output reset;
	output xclk;
	output reg [1:0] data_out;
	
	assign reset = reset_n;
	assign xclk = clk_25;
	assign h_sync = h_ref;
	
	reg byte_nr;
	reg start;
	reg [1:0] count;
	
	/* -----------------------------------------
		Paramters
	----------------------------------------- */ 
	parameter divider = 64;
	
	always @ (h_ref) begin
		if (h_ref)
			start <= 1;
		else
			start <= 0;
	end
	
	always @ (posedge pclk or negedge reset_n) begin
		if (!reset_n) begin
			// Reset registers
			data_out <= 0;
			byte_nr <= 0;
			count <= 0;
		end else if (start == 1) begin
			if (byte_nr && count == 0) begin
				if (data_in >= 0 && data_in <= divider-1) 
					data_out <= 2'b11; // BLUE
				else if (data_in >= divider && data_in <= divider*2-1) 
					data_out <= 2'b10; // PURPLE
				if (data_in >= divider*2 && data_in <= divider*3-1)
					data_out <= 2'b01; // L_BLUE
				else
					data_out <= 2'b00; // WHITE
			end
			count <= count + 1;
			byte_nr <= byte_nr + 1;
		end	
	end
	
endmodule