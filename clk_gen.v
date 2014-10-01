module clk_gen (

	reset_n,
	clk_50,
	clk_25

);

	input reset_n;
	input clk_50;
	
	output reg clk_25;
	
	always @ (posedge clk_50) begin
		if (!reset_n) 
			clk_25 <= 1'b0;
		else
			clk_25 <= ~clk_25;
	end
endmodule