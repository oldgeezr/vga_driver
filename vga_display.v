/* -----------------------------------------
  VGA image generator
----------------------------------------- */
module vga_display
(
	reset_n,
  clk_25,
  h_count,
  v_count, 
  data,
  bright,
  rgb,
  pixel_addr
);

	input reset_n;
	input             clk_25;
  input [9:0]       h_count;
  input [9:0]       v_count;
  input             data;
  input             bright;

  output [2:0]      rgb;
  output reg [14:0] pixel_addr;
  
  /* -----------------------------------------
    Paramters
  ----------------------------------------- */
  parameter BLACK   = 3'b000;
  parameter WHITE   = 3'b111;   // 11
  parameter L_BLUE  = 3'b011; // 10
  parameter PURPLE  = 3'b101; // 01
  parameter BLUE    = 3'b001;   // 00

  // Read pixel from framebuffer at address
  always @ (posedge clk_25 or negedge reset_n) begin
	if (~reset_n) begin
		pixel_addr <= 0;
	end else begin
		 if (pixel_addr == 19200) begin
			pixel_addr <= 0;
		 end

		 if (bright) begin
			pixel_addr <= pixel_addr + 1;
		 end
	  end
  end

  assign rgb = ~bright ? BLACK : {data, data, data};

endmodule
