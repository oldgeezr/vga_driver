module vga_driver (

	reset_n,
	clk_50,
	rgb,
	hs,
	vs

);

	input reset_n;
	input clk_50;
	output [2:0] rgb;
	output hs;
	output vs;
	
	wire clk_25;
	
	clk_gen clk_divider (
	
		.reset_n(reset_n),
		.clk_50(clk_50),
		.clk_25(clk_25)
	
	);
	
	vga_control vga_control (
	
		.reset_n(reset_n),
		.clk_25(clk_25),
		.h_sync(hs),
		.v_sync(vs),
		.h_count(h_count),
		.v_count(v_count),
		.bright(bright)
		
	);
	
	vga_display image (
	
		.h_count(h_count),
		.v_count(v_count),
		.bright(bright),
		.rgb(rgb),
	
	);
	
endmodule