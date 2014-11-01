module filler
#(
  parameter ADDR_WIDTH = 15 // Video format: QQVGA = 160x120 => 2^15
);
(
  // Input
  input                       reset_n,
  input                       clk_25,
  output reg                  we, // temp
  output reg [ADDR_WIDTH-1:0] write_addr, // temp
  output reg                  pixel // temp
);
  // temp
  reg [7:0] h_count;
  reg [6:0] v_count;

  always @ (posedge clk_25 or negedge reset_n) begin
    if (~reset_n) begin
      h_count <= 0;
      v_count <= 0;
      write_addr <= 0;
      we <= 1;
    end else begin
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
endmodule
