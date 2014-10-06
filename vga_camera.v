/* -----------------------------------------
	VGA Camera 0.3 Mp
----------------------------------------- */ 
module vga_camera (

	reset,
	reset_n,
	clk_25,
	xclk,
	pclk,
	data_in,
	data_out,
	write,
	h_ref,
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
	
	output reset;
	output xclk;
	output reg write;
	output reg [2:0] data_out;
	
	assign reset = reset_n;
	assign xclk = clk_25;
	
	reg [2:0] byte_nr;
	reg start;
	reg increment;
	reg [7:0] Y;
	reg [7:0] Cb;
	reg [7:0] Cr;
	
	/* -----------------------------------------
		Paramters
	----------------------------------------- */ 
	parameter BLACK = 3'b000;
	parameter RED = 3'b100;
	parameter WHITE = 3'b111;
	parameter GREEN = 3'b010;
	parameter BLUE = 3'b001;
	
	always @ (h_ref) begin
		if (h_ref)
			start <= 1;
		else
			start <= 0;
	end
	
	always @ (posedge pclk or negedge reset_n) begin
		if (!reset_n) begin
			// Reset registers
			increment <= 0;
			data_out <= 0;
			byte_nr <= 0;
			write <= 0;
		end else if (start == 1) begin
			if (byte_nr == 0) begin
				Cb <= data_in; // Cb
				increment <= increment + 1;
				byte_nr <= byte_nr + 1;
			end else if (byte_nr == 1) begin
				Y <= data_in; // Y
				if (increment) begin
					increment <= increment + 1;
					byte_nr <= byte_nr + 1;
				end else begin
					increment <= increment - 1;
					byte_nr <= byte_nr - 1;	
					write <= 1;
					data_out <= BLUE; // Y < 128 ? BLACK : WHITE;
				end
			end else if (byte_nr == 2) begin
				Cr <= data_in; // Cr
				increment <= increment - 1;
				write <= 1;
				data_out <= GREEN; // Y < 128 ? BLACK : WHITE;
			end
		end else begin
			// Reset registers
			increment <= 0;
			data_out <= 0;
			byte_nr <= 0;
			write <= 0;
		end	
	end
endmodule