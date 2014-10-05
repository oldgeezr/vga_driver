`timescale 1ns/1ps

module vga_driver_tb();

	reg reset_r;
	reg clk;
	
	wire reset_n;
	wire clk_50;
	wire rgb;
	wire hs;
	wire vs;
	
	always 
		#5 clk <= ~clk;
	
	assign clk_50 = clk;
	
	vga_driver vga_driver (
	
		.reset_n(reset_n),
		.clk_50(clk_50),
		.rgb(rgb),
		.hs(hs),
		.vs(vs)
	
	);
	
	assign reset_n = reset_r;

	initial begin
		reset_r = 1'b1;
		#5;
		reset_r = 1'b0;
		#25;
		reset_r = 1'b1;
	end

endmodule