/* -----------------------------------------
	VGA table/memory
----------------------------------------- */ 
module vga_table (
	
	reset_n,
	clk_50,
	write,
	read,
	pixel_in,
	pixel_out

);
	
	/* -----------------------------------------
		Inputs/Outputs
	----------------------------------------- */ 
	input reset_n;
	input clk_50;
	input write;
	input read;
	input [2:0] pixel_in;
	output [2:0] pixel_out;
	
	wire [18:0] addr;
	
	/* -----------------------------------------
		Parameters
	----------------------------------------- */ 
	parameter WIDTH = 3;
	parameter DEPTH = 640*240;
	
	/* -----------------------------------------
		Registers
	----------------------------------------- */ 
	reg [18:0] in_pos;
	reg [18:0] out_pos;
	
	assign addr = write ? in_pos : out_pos;
	
	// Write counter
	always @ (posedge read or negedge reset_n) begin
		if (!reset_n)
			in_pos <= 0;
		else begin
			in_pos <= in_pos + 1;
			if (in_pos == DEPTH-1) 
				in_pos <= 0;
		end
	end
	
	// Read counter
	always @ (posedge write or negedge reset_n) begin
		if (!reset_n)
			out_pos <= 0;
		else begin
			out_pos <= out_pos + 1;
			if (out_pos == DEPTH-1) 
				out_pos <= 0;
		end
	end
	
	/* -----------------------------------------
		Read/Write to memory
	----------------------------------------- */ 
	vga_frame frame_buffer (
		
		.data(pixel_in),
		.addr(addr),
		.we(write),
		.clk(clk_50),
		.q(pixel_out)
		
	);
	
	
endmodule