/* -----------------------------------------
	VGA table/memory
----------------------------------------- */ 
module vga_table (
	
	reset_n,
	clk_25,
	h_sync,
	bright,
	pixel_in,
	pixel_out

);
	
	/* -----------------------------------------
		Inputs/Outputs
	----------------------------------------- */ 
	input reset_n;
	input clk_25;
	input h_sync;
	input bright;
	input [1:0] pixel_in;
	output [1:0] pixel_out;
	
	/* -----------------------------------------
		Parameters
	----------------------------------------- */ 
	parameter WIDTH = 2;
	parameter DEPTH = 640*240;
	
	/* -----------------------------------------
		Registers
	----------------------------------------- */
	reg count;
	reg write;
	reg [14:0] write_addr;
	reg [14:0] read_addr;
	
	always @ (posedge clk_25 or negedge reset_n or negedge h_sync or posedge bright) begin
		if (!reset_n) begin
			count <= 0;
			write <= 0;
			write_addr <= 0;
			read_addr <= 0;
		end else if (write_addr == DEPTH-1)
			count <= 0;
		else if (read_addr == DEPTH-1)
			read_addr <= 0;
		else if (!h_sync) begin
			count <= 0;
			write <= 0;
			write_addr <= 0;
		end else if (bright)
			read_addr <= read_addr + 1;
		else begin
			if (count == 0) 
				write <= 1;
			else begin
				write <= 0;
				write_addr <= write_addr + 1;
			end
			count <= count + 1;
		end
	end
	
	/* -----------------------------------------
		Read/Write to memory
	----------------------------------------- */ 
	vga_frame frame_buffer (
		
		.data(pixel_in),
		.read_addr(read_addr),
		.write_addr(write_addr),
		.we(write),
		.clk(clk_25),
		.q(pixel_out)
		
	);
	
	
endmodule