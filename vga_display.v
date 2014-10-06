/* -----------------------------------------
	VGA image generator
----------------------------------------- */ 
module vga_display (

	clk_25,
	h_count,
	v_count,
	bright,
	read,
	data,
	rgb

);
	
	/* -----------------------------------------
		Inputs / Outputs
	----------------------------------------- */ 
	input clk_25;
	input [9:0] h_count;
	input [9:0] v_count;
	input [2:0] data;
	input bright;
	
	output reg read;
	output [2:0] rgb;
	reg [18:0] mem[0:(300000)];
	
	/* -----------------------------------------
		Internal wires
	----------------------------------------- */ 
	// wire frame = (h_count >= (16 + 48 + 96 + 10) && h_count <= (800 - 10)) && (v_count >= (10 + 2 + 29 + 10) && v_count <= (521 - 10));
	
	/* -----------------------------------------
		Paramters
	----------------------------------------- */ 
	parameter BLACK = 3'b000;
	parameter RED = 3'b100;
	parameter WHITE = 3'b111;

	/* -----------------------------------------
		Generate a white picture with a red frame on a black background
	----------------------------------------- */ 
<<<<<<< HEAD
	// assign rgb = ~bright ? BLACK : frame ? WHITE : RED;
	
	/* -----------------------------------------
		Generate a image from camera
	----------------------------------------- */ 
	assign rgb = ~bright ? BLACK : data;

	always @ (posedge clk_25) begin
		if (bright)
			read <= 1;
		else 
			read <= 0;
	end
=======
	// assign rgb = ~bright ? BLACK : frame ? RED : WHITE;
>>>>>>> 3510bd85ea053380ffd3ec7b4e725fbf85ed5fdc
	
	/* -----------------------------------------
		Comments
	----------------------------------------- */ 
<<<<<<< HEAD
	// reg[2:0] rgb_r = RED;
=======
	reg[2:0] rgb_r;
>>>>>>> 3510bd85ea053380ffd3ec7b4e725fbf85ed5fdc
	
	/*
	always @ *	
		if (~bright) rgb_r <= BLACK; // draw black if not in the bright zone
		else if ((h_count >= (16 + 48 + 96 + 10) && h_count <= (800 - 10)) && (v_count >= (10 + 2 + 29 + 10) && v_count <= (521 - 10))) // draw 10 px red frame
			rgb_r <= RED;
		else // draw white rectangle
			rgb_r <= WHITE;
			
<<<<<<< HEAD
	*/
	// assign rgb = rgb_r;
=======
	assign rgb = rgb_r;
>>>>>>> 3510bd85ea053380ffd3ec7b4e725fbf85ed5fdc
endmodule