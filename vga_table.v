/* -----------------------------------------
	VGA table/memory
----------------------------------------- */ 
module vga_table 
(	
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
	parameter R_DVIVIDER = 4;
	parameter W_DVIVIDER = 8;
	
	/* -----------------------------------------
		Registers
	----------------------------------------- */
	reg [2:0] r_count;
	reg [3:0] w_count;
	reg write;
	reg [14:0] write_addr;
	reg [14:0] read_addr;
	
	always @ (posedge clk_25 or negedge bright) begin
		if (!bright) begin
			read_addr <= 0;
			r_count <= 0;
		end else begin
			if (r_count < 7)
				r_count <= r_count + 1;
			else begin
				read_addr <= read_addr + 1;
				r_count <= 0;
			end
		end
	end
	
	always @ (posedge clk_25 or negedge h_sync or posedge bright) begin
		if (!h_sync) begin
			count <= 0;
			write <= 0;
			write_addr <= 0;
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