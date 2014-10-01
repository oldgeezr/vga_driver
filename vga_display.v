module vga_display (

	h_count,
	v_count,
	bright,
	rgb,

);

	input [9:0] h_count;
	input [9:0] v_count;
	input bright;
	
	output [2:0] rgb;
	
	wire frame = (h_count >= (16 + 48 + 96 + 10) && h_count <= (800 - 10)) && (v_count >= (10 + 2 + 29 + 10) && v_count <= (521 - 10));
	
	parameter BLACK = 3'b000;
	parameter RED = 3'b100;
	parameter WHITE = 3'b111;
	
	/*
		Draw a white picture with a red fram on a black background
	*/
	
	assign rgb = ~bright ? BLACK : frame ? RED : WHITE;
	
	// reg[2:0] rgb_r;
	
	/*
	always @ *	
		if (~bright) rgb_r <= BLACK; // draw black if not in the bright zone
		else if ((h_count >= (16 + 48 + 96 + 10) && h_count <= (800 - 10)) && (v_count >= (10 + 2 + 29 + 10) && v_count <= (521 - 10))) // draw 10 px red frame
			rgb_r <= RED;
		else // draw white rectangle
			rgb_r <= WHITE;
	*/	
endmodule