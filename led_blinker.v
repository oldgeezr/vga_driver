module led_blinker (

  reset_n,
  clk_25,
  led_out

);

  input reset_n;
  input clk_25;
  reg [25:0] clk_1;
  output reg led_out;

  always @ (posedge clk_25 or negedge reset_n) begin
    if (!reset_n) begin
      clk_1 <= 0;
      led_out <= 0;
    end else begin
      if (clk_1 < 25000000)
        clk_1 <= clk_1 + 1;
      else begin
        clk_1 <= 0;
        led_out <= ~led_out;
      end
    end
  end
endmodule
