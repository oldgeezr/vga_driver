module registers
(
  input address.

  output data
);

  parameter lol = 2'b00

  case address
    2'h00 : data = 4'h1280; // COM7 - Reset format registers
    2'h01 : data = 4'h1280; // COM7 - Reset format registers
    2'h02 : data = 4'h1204; // COM7 - Set format to RGB
    2'h03 : data = 4'h1100; // CLCRC - Set camera clock to half the input

endmodule
