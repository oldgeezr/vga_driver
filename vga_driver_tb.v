`timescale 1ns/1ps

module vga_driver_tb();

  reg         reset_n = 0;
  reg         clk_50 = 0;
  reg         pclk = 0;
  reg [7:0]   data_in;
  reg         h_ref;
  reg         v_sync;
  reg         start_pclk;

  wire        sio_d;
  wire        sio_c;
  wire [2:0]  rgb;
  wire        hs;
  wire        vs;
  wire        reset;
  wire        pwdn;
  wire        xclk;

  vga_driver vga_driver (

    .reset_n    (reset_n),
    .clk     		(clk_50),
    .pclk       (pclk),
    .data_in    (data_in),
    .h_ref      (h_ref),
    .v_sync     (v_sync),
    .sio_d      (sio_d),
    .sio_c      (sio_c),
    .rgb        (rgb),
    .hs         (hs),
    .vs         (vs),
    .reset      (reset),
    .pwdn       (pwdn),
    .xclk       (xclk)
  );

  always
    #10 clk_50 <= ~clk_50;

  always @ (posedge clk_50) begin
    pclk <= ~pclk;
  end

  initial begin
    #20
    reset_n = 1;
    start_pclk = 0;
    #20
    reset_n = 0;
    #40;
    reset_n = 1;
    data_in = 0;
    start_pclk = 1;
  end

  reg [9:0] h_count = 0;
  reg [8:0] v_count = 0;

  always @ (posedge pclk && start_pclk) begin
    if (h_count < 784) begin
      h_count = h_count + 1;
    end else begin
      h_count <= 0;
      if (v_count < 510) begin
        v_count = v_count + 1;
      end else begin
        v_count = 0;
      end
    end

    v_sync = 0;
    h_ref = 0;

    if (v_count < 3) begin
      v_sync = 1;
    end else if (v_count >= 20 && v_count < (510-10)) begin
      if (h_count >= (19+80+45) && h_count < 784) begin
        h_ref = 1;
      end
    end

    if ((v_count >= (20+60) && h_count >= (19+80+45+80)) && (v_count < (510-10-60) && h_count < (784-80))) begin
      data_in = 0;
    end else begin
      data_in = 255;
    end
  end
endmodule
