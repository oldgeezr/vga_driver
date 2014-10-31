`timescale 1ns/1ps

module framebuffer_dual_port_tb
#(
  parameter DATA_WIDTH=1,
  parameter ADDR_WIDTH=15
) ();

  reg        [(DATA_WIDTH-1):0] data;
  reg        [(ADDR_WIDTH-1):0] read_addr;
  reg        [(ADDR_WIDTH-1):0] write_addr;
  reg                           we;
  reg                           read_clock;
  reg                           write_clock;
  wire        [(DATA_WIDTH-1):0] q;

  reg [7:0] h_count;
  reg [6:0] v_count;

  initial begin
    read_clock = 0;
    write_clock = 0;
    data = 1;
    read_addr = 0;
    write_addr = 0;
    we = 1;

    h_count = 0;
    v_count = 0;
  end

  always #10 write_clock <= ~write_clock;
  always #6 read_clock <= ~read_clock;

  always @ (posedge write_clock) begin

    data <= 1;

    if ((h_count >= 40 && h_count < 120) && (v_count >= 30 && v_count < 90))
      data <= 0;

    if (h_count < 160)
      h_count <= 0;
    else
      h_count <= h_count + 1;

    if (v_count < 120)
      v_count <= 0;
    else
      v_count <= v_count + 1;

    if (read_addr < 19200)
      read_addr <= 0;
    else
      read_addr <= read_addr + 1;

    if (write_addr < 19200)
      write_addr <= 0;
    else
      write_addr <= write_addr + 1;
  end


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
