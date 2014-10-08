module sccb 
(
	input reset_n,
	input clk_24,
	
	output reg sio_c,
	output reg sio_d,
	
	output reg data_clk
);

	/* Comments
		SIO_C = 400kHz
	*/
	
	parameter input_clk = 24_000_000;
	parameter bus_clk = 400_000;
	parameter divider = (input_clk/bus_clk/4);

	reg [5:0] counter; // divider*4 = 60 => 2^6
	reg stretch;
	reg [1:0] temp;

	// Generate clock of 400kHz (50000/125)
	always @ (posedge clk_24 or negedge reset_n) begin
		if (!reset_n) begin
			counter <= 0;
			stretch <= 0;
			temp <= 0;
		end else begin
			if (counter == divider*4-1)
				counter <= 0;
			else if (stretch == 0)
				counter <= counter + 1;
			if (counter >= 0 && counter < divider*1-1) begin
				sio_c <= 0;
				data_clk <= 0;
				temp <= 0;
			end else if (counter >= divider && counter < divider*2-1) begin
				sio_c <= 0;
				data_clk <= 1;
				temp <= 1;
			end else if (counter >= divider*2 && counter < divider*3-1) begin
				sio_c <= 1;
				data_clk <= 1;
				temp <= 2;
			end else begin
				sio_c <= 1;
				data_clk <= 0;
				temp <= 3;
			end 	
		end
	end
	
	parameter idle = 0, start = 1, data = 2, stop = 3;
	
	reg [1:0] state, next_state;
endmodule