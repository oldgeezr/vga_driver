module resolution
(
	// Input
	input reset_n,
	input clk_25,
	input pclk,
	input [7:0] data_in,
	input h_ref,
	input v_sync,
	// Output
	output reg [1:0] data_out
);

	reg [1:0] v_count;
	reg [1:0] h_count;

	always @ (posedge clk_25 or negedge reset_n) begin
		if (!reset_n) begin
			v_count <= 0;
			h_count <= 0;
		end else begin
			if (!h_ref) begin
				
				
			end else begin
				if (h_count == 0) begin
					// Record data
				end
				h_count <= h_count + 1;
			end
		end
	end

endmodule