/* -----------------------------------------
  Clock divider: Divides clock by 2
----------------------------------------- */
module clk_gen (

  input       reset_n,
  input       clk_50,
  output reg  clk_25

);

  /* -----------------------------------------
    Behavioural
  ----------------------------------------- */
  always @ (posedge clk_50 or negedge reset_n) begin
    if (~reset_n)
      clk_25 <= 0;
    else
      clk_25 <= ~clk_25;
  end
endmodule
