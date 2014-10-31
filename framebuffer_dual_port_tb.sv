module framebuffer_dual_port_tb
#(
  parameter DATA_WIDTH=1,
  parameter ADDR_WIDTH=15
) ();

  wire       [(DATA_WIDTH-1):0] data;
  wire       [(ADDR_WIDTH-1):0] read_addr;
  wire       [(ADDR_WIDTH-1):0] write_addr;
  wire                          we;
  wire                          read_clock;
  wire                          write_clock,
  reg        [(DATA_WIDTH-1):0] q;
  reg                           clk;

  initial begin
    clk = 0;
    read_addr = 0;
    write_add = 0;
    we = 0;
  end

  always * begin
    #5 clk <= ~clk;
  end

  // always @ (posedge clk)

  framebuffer_dual_port framebuffer
  (
    .data                 (data),
    .read_addr            (read_addr),
    .write_addr           (write_addr),
    .we                   (we),
    .read_clock           (read_clock),
    .write_clock          (write_clock),
    .q                    (q)
  );

endmodule
