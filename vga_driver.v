/* -----------------------------------------
  VGA driver
----------------------------------------- */
module vga_driver
#(
  parameter ADDR_WIDTH = 15 // Video format: QQVGA = 160x120 => 2^15
)
(
  // Inputs
  input         reset_n,
  input         clk_50,
  input         pclk,
  input [7:0]   data_in,
  input         h_ref,
  input         v_sync,
  // Input and output
  inout         sio_d,
  // Output
  output        sio_c,
  output [2:0]  rgb,
  output        hs,
  output        vs,
  output        reset,
  output        pwdn,
  output        xclk
);
  /* -----------------------------------------
    Internal wires
  ----------------------------------------- */
  // Clock wires
  wire        clk_25;
  wire [9:0]  h_count;
  wire [9:0]  v_count;
  wire        bright;

  /* -----------------------------------------
    Internal registers
  ----------------------------------------- */

  // Clock divider by 2
  clk_gen clk_divider
  (
    .reset_n      (reset_n),
    .clk_50       (clk_50),
    .clk_25       (clk_25)
  );

  // VGA control unit
  vga_control vga_control
  (
    .reset_n      (reset_n),
    .clk_25       (clk_25),
    .h_sync       (hs),
    .v_sync       (vs),
    .h_count      (h_count),
    .v_count      (v_count),
    .bright       (bright)
  );

  wire                  pixel;
  wire [ADDR_WIDTH-1:0] write_addr;
  wire [ADDR_WIDTH-1:0] read_addr;
  wire                  we;
  wire                  q;

  // Image generator
  vga_display image
  (
    .h_count      (h_count),
    .v_count      (v_count),
    .bright       (bright),
    .data         (q),
    .rgb          (rgb),
    .pixel_addr   (read_addr)
  );

  camera_controller camera
  (
    .reset_n      (reset_n),
    .clk_25       (clk_25),
    .pclk         (pclk),
    .data_in      (data_in),
    .h_ref        (h_ref),
    .v_sync       (v_sync),
    .sio_d        (sio_d),
    .reset        (reset),
    .pwdn         (pwdn),
    .xclk         (xclk),
    .sio_c        (sio_c),
    .we           (we),
    .write_addr   (write_addr),
    .pixel        (pixel)
  );

  framebuffer_dual_port framebuffer
  (
    .data         (pixel),
    .read_addr    (read_addr),
    .write_addr   (write_addr),
    .we           (we),
    .read_clock   (clk_25),
    .write_clock  (pclk), // Try with both clk_25 and pclk. pclk might be unstable
    .q            (q)
  );

endmodule
