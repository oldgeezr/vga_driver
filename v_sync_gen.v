// this module is temporary

module v_sync_gen (

	clk_25,
	reset_n,
	v_sync

);

	input clk_25;
	input reset_n;
	
	output reg v_sync;
	
	reg[9:0] counter;
	
	always @ (posedge clk_25) begin	
		if (!reset_n) begin
			v_sync <= 1'b1;
			counter <= 9'b000000000;
		end else begin
			if (counter < 16) // back porch
				v_sync <= 1'b1;
			else if (counter < (16 + 96)) // h_sync active low
				v_sync <= 1'b0;
			else // front porch and active
				v_sync <= 1'b1;
			// counter
			if (counter == 800)
				counter <= 9'b000000000;
			else
				counter <= counter + 9'b1;
		end
	end
endmodule