module sccb_master
(
	input reset_n,
	input clk_50,

	output sio_c,
	output sio_d
);

	parameter input_clk = 50_000_000;
	parameter bus_clk = 400_000;
	parameter divider = (input_clk/bus_clk/4);

	reg [6:0] clk_counter; // divider*4 = 125 => 2^7
	reg [4:0] data_counter; // 7+1+1+8+1+8+1 = 9*3 = 27
	reg s_clk;
	reg d_clk;
  // reg [6:0] id;
  // reg [7:0] address;
  // reg [7:0] value;

	// Generate SIO_C DATA_C at 400kHz
	always @ (posedge clk_50 or negedge reset_n) begin
		if (~reset_n) begin
			clk_counter <= 0;
		end else begin
			if (clk_counter == divider*4-1)
				clk_counter <= 0;

			if (clk_counter >= 0 && clk_counter <= divider*1-1) begin
				s_clk <= 0;
				d_clk <= 0;
			end else if (clk_counter >= divider && clk_counter <= divider*2-1) begin
				s_clk <= 0;
				d_clk <= 1;
			end else if (clk_counter >= divider*2 && clk_counter <= divider*3-1) begin
				s_clk <= 1;
				d_clk <= 1;
			end else begin
				s_clk <= 1;
				d_clk <= 0;
			end
		end
	end

  wire [6:0] id;
  wire [7:0] address;
  wire [7:0] value;
  wire [26:0] data;

  assign data = {id, "10", address, '0', value, '0'}; // Might need a last high bit



endmodule
