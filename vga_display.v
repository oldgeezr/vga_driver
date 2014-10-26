/* -----------------------------------------
	VGA image generator
----------------------------------------- */ 
module vga_display 
(
	clk_25,
	h_count,
	v_count,
	bright,
	data,
	rgb,
	pixel_addr
);
	
	/* -----------------------------------------
		Inputs / Outputs
	----------------------------------------- */ 
	input clk_25;
	input [9:0] h_count;
	input [9:0] v_count;
	input data;
	input bright;
	
	output [2:0] rgb;
	output reg [14:0] pixel_addr = 0;
	
	/* -----------------------------------------
		Internal wires
	----------------------------------------- */ 
	// wire frame = (h_count >= (16 + 48 + 96 + 10) && h_count <= (800 - 10)) && (v_count >= (10 + 2 + 29 + 10) && v_count <= (521 - 10));
	
	/* -----------------------------------------
		Paramters
	----------------------------------------- */ 
	parameter BLACK = 3'b000;
	parameter WHITE = 3'b111; 	// 11
	parameter L_BLUE = 3'b011;	// 10
	parameter PURPLE = 3'b101;	// 01
	parameter BLUE = 3'b001;   // 00
	
	// Read pixel from framebuffer at address
	always @ (posedge clk_25) begin
		
		if (pixel_addr == 19200) begin
			pixel_addr <= 0;
		end
		
		if (bright) begin
			pixel_addr <= pixel_addr + 1;
		end
	end
	
	assign rgb = ~bright ? BLACK : {data, data, data};

endmodule