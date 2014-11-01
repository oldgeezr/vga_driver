`timescale 1ns/1ps

module filler_tb
#(
  parameter ADDR_WIDTH = 15 // Video format: QQVGA = 160x120 => 2^15
)();

  // Input
  reg                    reset_n;
  reg                    clk_25;

  wire [(ADDR_WIDTH-1):0] write_addr;
  wire                    we;
  wire                    pixel;

  initial begin
    clk_25 = 0;
    reset_n = 1;

    #5 reset_n = 0;

    #10 reset_n = 1;
  end


  always #5 clk_25 = ~clk_25;


  filler fill_FB
  (
    .clk_25(clk_25),
    .reset_n(reset_n)
    .we(we),
    .write_addr(write_addr),
    .pixel(pixel)
  );

endmodule
