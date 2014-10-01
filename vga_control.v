module vga_control (

	reset_n,
	clk_25,
	h_sync,
	v_sync,
	h_count,
	v_count,
	bright

);

	input reset_n;
	input clk_25;
	
	output reg h_sync;
	output reg v_sync;
	output reg[9:0] h_count;
	output reg[9:0] v_count;
	output reg bright;
	
	always @ (posedge clk_25) begin	
		if (!reset_n) begin
			h_sync <= 1'b1;
			v_sync <= 1'b1;
			h_count <= 9'b000000000;
			v_count <= 9'b000000000;
			bright <= 1'b0;
		end else begin
		
			bright <= 1'b0; // disable bright zone
		
			/*
				Horisontal syncronization
			*/
			if (h_count < 16) // 16 clocks of back porch
				h_sync <= 1'b1;
			else if (h_count < (16 + 96)) // 96 clocks of h_sync active low
				h_sync <= 1'b0;
			else if (h_count < (16 + 96 + 48)) // 48 clocks of front porch
				h_sync <= 1'b1;
			else // 640 clocks active : concatinate with if statement over
				h_sync <= 1'b1;
			// horisontal and vertical counter
			if (h_count == 800) begin // reset h_count and increment v_count
				h_count <= 9'b000000000;
				v_count <= 9'b1;
			end else // increment h_count
				h_count <= h_count + 9'b1;
				
			/*
				Vertical syncronization
			*/
			if (v_count < 10) // 10 lines of back porch
				v_sync <= 1'b1;
			else if (v_sync < (10 + 2)) // 2 lines of v_sync pulse active low
				v_sync <= 1'b0;
			else if (v_count < (10 + 2 + 29)) // 29 lines of front porch
				v_sync <= 1'b1;
			else begin // 480 lines active
				v_sync <= 1'b1;
				bright <= 1'b1; // entering bright section
			end
			// vertical counter
			if (v_count == 521) // reset v_count
				v_count <= 9'b000000000;
		end
	end
endmodule