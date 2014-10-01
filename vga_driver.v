/* -----------------------------------------
	VGA driver
----------------------------------------- */ 
module vga_driver (

	reset_n,
	clk_50,
	rgb,
	hs,
	vs

);

	/* -----------------------------------------
		Inputs / Outputs
	----------------------------------------- */ 
	input reset_n;
	input clk_50;
	output [2:0] rgb;
	output hs;
	output vs;
	
	/* -----------------------------------------
		Internal wires
	----------------------------------------- */
	wire clk_25;
	wire [9:0] h_count;
	wire [9:0] v_count;
	wire bright;
	
	/* -----------------------------------------
		Internal registers
	----------------------------------------- */ 
	
	/* -----------------------------------------
		Components
	----------------------------------------- */ 
	
	// Clock divider by 2
	clk_gen clk_divider (
	
		.reset_n(reset_n),
		.clk_50(clk_50),
		.clk_25(clk_25)
	
	);
	
	// VGA control unit
	vga_control vga_control (
	
		.reset_n(reset_n),
		.clk_25(clk_25),
		.h_sync(hs),
		.v_sync(vs),
		.h_count(h_count),
		.v_count(v_count),
		.bright(bright)
		
	);
	
	// Image generator
	vga_display image (
	
		.h_count(h_count),
		.v_count(v_count),
		.bright(bright),
		.rgb(rgb)
	
	);
	
	/* -----------------------------------------
		Initial procedure
	----------------------------------------- */ 
endmodule