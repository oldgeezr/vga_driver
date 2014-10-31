module vga_capture
#(parameter ADDR_WIDTH = 15) // Video format: QQVGA = 160x120 => 2^15
(
  input                       reset_n,
  input                       pclk,
  input                       h_ref,
  input                       v_sync,
  input [7:0]                 data_in,

  output reg [7:0]            Y, // Y comonent of YUV
  output reg [ADDR_WIDTH-1:0] write_addr,
  output reg                  we
);

  reg       v_sync_inv;
  reg [2:0] h_byte; // 0-7
  reg [2:0] v_row; // 0-7

  wire v_pulse;

  // Generate the inverted v_sync signal
  always @ (posedge pclk or negedge reset_n) begin
    if (~reset_n) begin
      v_sync_inv <= 1;
    end else begin
      v_sync_inv <= ~v_sync;
    end
  end

  // 1 CC pulse @ posedge v_sync
  assign v_pulse = v_sync & v_sync_inv;

  // Get 160x120 bytes from the camera and write to framebuffer
  always @ (posedge pclk or negedge reset_n) begin
    if (~reset_n) begin
      h_byte <= 0;
      v_row <= 7;
      Y <= 0;
      write_addr <= 2**ADDR_WIDTH-1;
      we <= 0;
    end else begin
		// if pclk = 1
      we <= 0;

      if (v_pulse) begin
        h_byte <= 0;
        v_row <= v_row + 1;
        write_addr <= 2**ADDR_WIDTH-1;
      end else begin
        if (v_row == 0) begin // Get every 8'th row CHECK IF PCLK IS IN FACT 25 MHZ!
          if (h_ref) begin
            if (h_byte == 0) begin
              Y <= data_in; // Get every 8'th byte
              write_addr <= write_addr + 1;
              we <= 1;
            end
            h_byte <= h_byte + 1;
          end
        end
      end
    end
  end
endmodule
