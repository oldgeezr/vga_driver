// clk_sys.v

// Generated using ACDS version 14.0 200 at 2014.10.27.17:19:54

`timescale 1 ps / 1 ps
module clk_sys (
		input  wire  inclk,  //  altclkctrl_input.inclk
		output wire  outclk  // altclkctrl_output.outclk
	);

	clk_sys_altclkctrl_0 altclkctrl_0 (
		.inclk  (inclk),  //  altclkctrl_input.inclk
		.outclk (outclk)  // altclkctrl_output.outclk
	);

endmodule