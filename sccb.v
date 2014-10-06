module sccb 
(
	input reset_n,
	input clk_50
);

	reg [8:0] counter;

	always @ (posedge clk_50 or negedge reset_n) 
		if (!reset_n) 
			counter <= 0;
		else begin
			if (counter < 500) 
				counter <= counter - 1;
			else 
				counter <= 0;
		end
endmodule