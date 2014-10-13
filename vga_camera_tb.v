`timescale 1ns/1ps

module vga_camera_tb();

	reg reset_r;
	reg clk;
	
	
	always 
		#5 clk <= ~clk;
	
	assign clk_25 = clk;
	
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
	
	assign reset_n = reset_r;

	initial begin
		reset_r = 1'b1;
		#5;
		reset_r = 1'b0;
		#25;
		reset_r = 1'b1;
	end

endmodule