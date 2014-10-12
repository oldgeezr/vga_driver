/* -----------------------------------------
	VGA table/memory
----------------------------------------- */ 
module vga_table 
(	
	// Input
	input reset_n,
	input clk_25,
	input h_sync,
	input bright,
	input [1:0] pixel_in,
	// Output
	output [1:0] pixel_out
);

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
	
	// Start the read counter when in the bright area
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
	
	// Start the write counter at the synchronization puls from camera
	always @ (posedge clk_25 or negedge h_sync) begin
		if (!h_sync) begin
			w_count <= 0;
			write <= 0;
			write_addr <= 0;
		end else begin
			if (w_count == 0) 
				write <= 1;
			else begin
				write <= 0;
				write_addr <= write_addr + 1;
			end
			w_count <= w_count + 1;
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