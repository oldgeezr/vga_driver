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
	input [9:0] h_count;
	input [9:0] v_count;
	input [2:0] data;
	input bright;
	
	output reg [2:0] rgb;
	
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
	// assign rgb = ~bright ? BLACK : frame ? WHITE : RED;
	
	/* -----------------------------------------
		Generate a image from camera
	----------------------------------------- */ 
	// assign rgb = ~bright ? BLACK : data;

	always @ (posedge clk_25) begin
		if (bright)
			rgb <= data;
	end
		
	
	/* -----------------------------------------
		Comments
	----------------------------------------- */ 
	// reg[2:0] rgb_r = RED;
	
	/*
	always @ *	
		if (~bright) rgb_r <= BLACK; // draw black if not in the bright zone
		else if ((h_count >= (16 + 48 + 96 + 10) && h_count <= (800 - 10)) && (v_count >= (10 + 2 + 29 + 10) && v_count <= (521 - 10))) // draw 10 px red frame
			rgb_r <= RED;
		else // draw white rectangle
			rgb_r <= WHITE;
			
	*/
	// assign rgb = rgb_r;
endmodule