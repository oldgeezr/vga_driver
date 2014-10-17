/* -----------------------------------------
	VGA control unit
----------------------------------------- */ 
module camera_control 
(
	// Input
	input reset_n,
	input clk_24,
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

	assign reset = reset_n;
	assign xclk = clk_24;
	assign vs = ~v_sync;
	
	reg [9:0] h_count;
	reg byte_nr;
	
	parameter BLACK = 3'b000;
	parameter WHITE = 3'b111;
	
	always @ (posedge pclk or posedge v_sync) begin
		
		// Reset horisontal counter at new frame
		if (v_sync) begin
			h_count <= 0;
		end else begin
		
			// Send horisontal synchronization pulse
			if (h_count < 80) begin 
				hs <= 0;
			end else begin
				hs <= 1;
			end
			
			// Output given the Y component of YUV
			if (h_ref) begin
				if (byte_nr) begin
					if (data_in < 128) begin
						data_out <= BLACK;
					end else begin
						data_out <= WHITE;
					end
				end
				byte_nr <= byte_nr + 1;
			end
			
			// Reset the horisontal counter when maxed
			if (h_count < 784) begin
				h_count <= h_count + 1;
			end else begin
				h_count <= 0;
			end
		end
	end
	
endmodule
