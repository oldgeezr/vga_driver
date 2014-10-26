module single_pulse
(
  input clk,
  input reset_n,
  input ref,

  // output reg pulse1,
  output pulse2
);

  reg ref_inv;

  // This generates a pulse one clock cycle after the ref signal goes high
  always @ (posedge clk) begin
    if (~reset_n) begin
      // pulse1 <= 0;
      ref_inv <= 1;
    end else begin
      //if (ref) begin
        //pulse1 <= ref & ref_inv;
      //end
      ref_inv <= ~ref;
    end
  end

  // This generates a pulse when the ref signal goes high
  assign pulse2 = ref & ref_inv;

endmodule
