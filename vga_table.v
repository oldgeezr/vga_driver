module vga_table (
	
	reset_n,
	clk_50,
	write,
	read,
	in_pos,
	out_pos,
	pixel_in,
	pixel_out

);

	input reset_n;
	input clk_50;
	input write;
	input read;
	input [2:0] pixel_in;
	input in_pos;
	input out_pos;
	
	output reg [2:0] pixel_out;
	
	parameter WIDTH = 3;
	parameter DEPTH = 640*480;
	
	reg [WIDTH-1:0] pixels [0:DEPTH-1];
	
	always @ (posedge clk_50 or negedge reset_n) begin
		if (!reset_n) 
			pixels[0] <= 0;
			// Do something 
		else if (write)
			pixels[in_pos] <= pixel_in;
		else if (read)
			pixel_out <= pixels[out_pos];
	end
endmodule