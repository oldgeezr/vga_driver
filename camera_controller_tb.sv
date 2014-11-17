/* -----------------------------------------
  Camera Control Unit Tb
----------------------------------------- */
module camera_controller_tb
#(
  parameter ADDR_WIDTH = 15 // Video format: QQVGA = 160x120 => 2^15
)

  // Input
  reg                   reset_n,
  reg                   clk_25,
  reg                   pclk,
  reg             [7:0] data_in,
  reg                   h_ref,
  reg                   v_sync,
  // Input and output
  reg                   sio_d,
  // Outputs
  reg                  reset,
  reg                  pwdn,
  reg                  xclk,
  reg                  sio_c,
  reg              we, // temp
  reg [ADDR_WIDTH-1:0] write_addr, // temp
  reg              pixel // temp

  /* -----------------------------------------
    Internal wiring
  ----------------------------------------- */
  wire [7:0] Y;

  // temp
  reg [7:0] h_count;
  reg [6:0] v_count;

  /* -----------------------------------------
    Behavioural
  ----------------------------------------- */
  // Pass clock signal to camera
  assign xclk = clk_25; // Maybe try to use clk_50 and set the registers
  // Pass inverted reset to camera
  assign reset = ~reset_n; // Should be active high
  // Turn on camera
  assign pwdn = 0; // Should be active high
  // Hold SCCB data line high impedance
  assign sio_d = 1'bz;
  // Hold SCCB clock line high
  assign sio_c = 1;
  // Comprise 8 bits to 1 bit. Go from 255 colors to 2 colors
  // assign pixel = (Y[7:6] == 0) ? 0 : 1; // Pixel is either BLACK or WHITE

  always @ (posedge clk_25 or negedge reset_n) begin
    if (~reset_n) begin
      h_count <= 0;
      v_count <= 0;
      write_addr <= 0;
      we <= 1;
    else begin
      pixel <= 1;

      if ((h_count > 40 && h_count < 119) && (v_count > 30 && v_count < 89))
        pixel <= 0;

      if (h_count < 159)
        h_count <= h_count + 1;
      else begin
        h_count <= 0;
        if (v_count < 119)
          v_count <= v_count + 1;
        else
          v_count <= 0;
      end

      if (write_addr < 19199)
        write_addr <= write_addr + 1;
      else
        write_addr <= 0;
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
    .write_addr     (write_addr),
    .we             (we)
  );

endmodule
