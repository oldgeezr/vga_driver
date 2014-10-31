/* -----------------------------------------
  VGA control unit
----------------------------------------- */
module camera_controller
#(
  parameter ADDR_WIDTH = 15 // Video format: QQVGA = 160x120 => 2^15
)
(
  // Input
  input                   reset_n,
  input                   clk_25,
  input                   pclk,
  input             [7:0] data_in,
  input                   h_ref,
  input                   v_sync,
  // Input and output
  inout                   sio_d,
  // Output
  output                  reset,
  output                  pwdn,
  output                  xclk,
  output                  sio_c,
  output reg                 we,
  output reg [ADDR_WIDTH-1:0] write_addr,
  output reg                 pixel
);

	reg [7:0] h_count;
	reg [6:0] v_count;

  wire [7:0] Y;
  
  wire [ADDR_WIDTH-1:0] pixel_addr;

  assign xclk = clk_25; // Maybe try to use clk_50 and set the registers
  assign reset = reset_n; // Should be active low

  // Turn on camera
  assign pwdn = 0; // Should be active high

  // Hold SCCB data line high imp and clk high
  assign sio_d = 1'bz;
  assign sio_c = 1;

  // Comprise 8 bits to 1 bit. Go from 255 colors to 2 colors
  // assign pixel = (Y[7:5] == 7) ? 1 : 0; // Pixel is either BLACK or WHITE
  
	 always @ (posedge pclk or negedge reset_n) begin
			if (~reset_n) begin
				h_count <= 0;
				v_count <= 0;
				write_addr <= 2**ADDR_WIDTH-1;
				we <= 0;
			end else begin
			  we <= 1;
			  if ((v_count >= 40 && v_count < 80) && (h_count >= 40 && h_count < 120)) begin
					pixel <= 0;
			  end else begin
					pixel <= 1;
			  end
			  
			  if (h_count < 160) begin
				 h_count <= h_count + 1;
			  end else begin
				 h_count <= 0;
				 if (v_count < 120 ) begin
					v_count <= v_count + 1;
				 end else begin
					v_count <= 0;
				 end
			  end
			
			
				 
				if (write_addr < 19200) begin
						write_addr <= write_addr + 1;
				end else begin
					write_addr <= 0;
			   end	
			end
		end 

  // Capture valid pixels
  vga_capture ov7670_camera
  (
    .reset_n        (reset_n),
    .pclk           (pclk),
    .h_ref          (h_ref),
    .v_sync         (v_sync),
    .data_in        (data_in),
    .Y              (Y),
    .write_addr     (pixel_addr),
    .we             ()
  );

endmodule
