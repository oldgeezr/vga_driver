/* -----------------------------------------
	VGA driver
----------------------------------------- */ 
module vga_driver (

	reset,
	reset_n,
	clk_50,
	xclk,
	pclk,
	data_in,
	rgb,
	hs,
	vs,
	h_ref,
	v_sync
	// led_out

);

	/* -----------------------------------------
		Inputs / Outputs
	----------------------------------------- */ 
	input reset_n;
	input clk_50;
	
	input pclk;
	input [7:0] data_in;
	input h_ref;
	input v_sync;
	output [2:0] rgb;
	output hs;
	output vs;
	output reset;
	output xclk;
	
	
	// output led_out;
	
	/* -----------------------------------------
		Internal wires
	----------------------------------------- */
<<<<<<< HEAD
	// Clock wires
=======
>>>>>>> 3510bd85ea053380ffd3ec7b4e725fbf85ed5fdc
	wire clk_25;
	wire [9:0] h_count;
	wire [9:0] v_count;
	wire bright;
	
	/* -----------------------------------------
		Internal registers
	----------------------------------------- */ 
	
	// Image wires
	wire [9:0] h_count;
	wire [9:0] v_count;
	wire bright;
	wire [2:0] data_out;
	
	// VGA Control wires
	
	// VGA Camera wires
	wire write;
	wire read;
	wire [2:0] pixel_in;
	wire [2:0] pixel_out;
	
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
	
		.clk_25(clk_25),
		.h_count(h_count),
		.v_count(v_count),
		.bright(bright),
<<<<<<< HEAD
		.read(read),
		.data(pixel_out),
=======
>>>>>>> 3510bd85ea053380ffd3ec7b4e725fbf85ed5fdc
		.rgb(rgb)
	
	);
	
<<<<<<< HEAD
	/* VGA Camera 
	vga_camera camera (
	
		.reset(reset),
		.reset_n(reset_n),
		.clk_25(clk_25),
		.xclk(xclk),
		.pclk(pclk),
		.write(write),
		.data_in(data_in),
		.data_out(data_out),
		.h_ref(h_ref),
		.v_sync(v_sync)
	
	);
	
	// Frame buffer
	vga_table mem (
		
		.reset_n(reset_n),
		.clk_50(clk_50),
		.write(write),
		.read(read),
		.pixel_in(data_out),
		.pixel_out(pixel_out)

	);
	
	/* Led blinker
	led_blinker blinker (
	
		.reset_n(reset_n),
		.clk_25(clk_25),
		.led_out(led_out)
	
	);*/
=======
	/* -----------------------------------------
		Initial procedure
	----------------------------------------- */ 
>>>>>>> 3510bd85ea053380ffd3ec7b4e725fbf85ed5fdc
endmodule