/* -----------------------------------------
  VGA control unit
----------------------------------------- */
module camera_controller
#(parameter ADDR_WIDTH = 15) // Video format: QQVGA = 160x120 => 2^15
(
  // Input
  input                   reset_n,
  input                   clk_25,
  input                   pclk,
  input [7:0]             data_in,
  input                   h_ref,
  input                   v_sync,
  // Input and output
  inout                   sio_d,
  // Output
  output                  reset,
  output                  pwdn,
  output                  xclk,
  output                  sio_c,
  output                  we,
  output [ADDR_WIDTH-1:0] write_addr,
  output                  pixel
);

  wire [7:0] Y;

  assign xclk = clk_25; // Maybe try to use clk_50 and set the registers
  assign reset = ~reset_n; // Should be active high

  // Turn on camera
  assign pwdn = 0; // Should be active high

  // Hold SCCB data line high imp and clk high
  assign sio_d = 1'bz;
  assign sio_c = 1;

  // Comprise 8 bits to 1 bit. Go from 255 colors to 2 colors
  assign pixel = (Y[7:6] == 0) ? 0 : 1; // Pixel is either BLACK or WHITE

  // Capture valid pixels
  vga_capture ov7670_camera
  (
    .reset_n        (reset_n),
    .pclk           (pclk),
    .h_ref          (h_ref),
    .v_sync         (v_sync),
    .data_in        (data_in),
    .Y              (Y),
    .write_addr     (write_addr),
    .we             (we)
  );

endmodule
