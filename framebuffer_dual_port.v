/* -----------------------------------------
  Framebuffer 160x120 QQVGA
----------------------------------------- */
module framebuffer_dual_port
#(
  parameter DATA_WIDTH=1,
  parameter ADDR_WIDTH=15
)
(
  input       [(DATA_WIDTH-1):0] data,
  input       [(ADDR_WIDTH-1):0] read_addr,
  input       [(ADDR_WIDTH-1):0] write_addr,
  input                          we,
  input                          read_clock,
  input                          write_clock,
  output reg  [(DATA_WIDTH-1):0] q
);

  // Declare the RAM variable
  reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

  /* -----------------------------------------
    Behavioural
  ----------------------------------------- */
  always @ (posedge write_clock) begin
    // Write
    if (we)
      ram[write_addr] <= data;
  end

  always @ (posedge read_clock) begin
    // Read
    q <= ram[read_addr];
  end

endmodule
