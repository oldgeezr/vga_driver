/* -----------------------------------------
	VGA driver
----------------------------------------- */ 
module vga_driver 
(
	// Inputs
	input reset_n,
	input clk_50,
	input clk_24,
	input pclk,
	input [7:0] data_in,
	input h_ref,
	input v_sync,
	// Output
	output [2:0] rgb,
	output hs,
	output vs,
	output reset,
	output xclk
	// output led_out;
);

	/* -----------------------------------------
		Internal wires
	----------------------------------------- */
	// Clock wires
	wire clk_25;
	//wire [9:0] h_count;
	//wire [9:0] v_count;
	//wire bright;
	
	/* -----------------------------------------
		Internal registers
	----------------------------------------- */ 
	
	// Image wires
	wire [1:0] data_out;
	
	// VGA Control wires
	
	// VGA Camera wires
	//wire write;
	//wire read;
	//wire h_sync;
	//wire [1:0] pixel_in;
	//wire [1:0] pixel_out;
	
	/* -----------------------------------------
		Internal registers
	----------------------------------------- */ 
	
	/* -----------------------------------------
		Components
	----------------------------------------- */ 
	
	/* Clock divider by 2
	clk_gen clk_divider (
	
		.reset_n(reset_n),
		.clk_50(clk_50),
		.clk_25(clk_25)
	
	);*/
	
	/* VGA control unit
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
	
		.clk_25(clk_25),
		.h_count(h_count),
		.v_count(v_count),
		.bright(bright),
		.data(pixel_out),
		.rgb(rgb)
	
	);*/
	
	camera_control camera
	(
		.reset_n(reset_n),
		.reset(reset),
		.clk_24(clk_24),
		.pclk(pclk),
		.xclk(xclk),
		.data_in(data_in),
		.h_ref(h_ref),
		.v_sync(v_sync),
		.hs(hs),
		.vs(vs),
		.data_out(rgb)
	);

	/* VGA Camera 
	vga_camera camera (
	
		.reset(reset),
		.reset_n(reset_n),
		.clk_25(clk_25),
		.xclk(xclk),
		.pclk(pclk),
		.h_sync(h_sync),
		.data_in(data_in),
		.data_out(data_out),
		.h_ref(h_ref),
		.v_sync(v_sync)
	
	);
	
	// Frame buffer
	vga_table mem (
		
		.reset_n(reset_n),
		.clk_25(clk_25),
		.h_sync(h_sync),
		.bright(bright),
		.pixel_in(data_out),
		.pixel_out(pixel_out)

	);
	
	// Led blinker
	led_blinker blinker (
	
		.reset_n(reset_n),
		.clk_25(clk_25),
		.led_out(led_out)
	
	);*/

	/* -----------------------------------------
		Initial procedure
	----------------------------------------- */ 

endmodule