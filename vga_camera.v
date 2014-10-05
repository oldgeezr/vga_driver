module vga_camera (

	reset,
	reset_n,
	clk_25,
	xclk,
	pclk,
	data_in,
	data_out,
	write,
	in_pos,
	h_ref,
	v_sync
	
);

	input reset_n;
	input clk_25;
	input pclk;
	input [7:0] data_in;
	input h_ref;
	input v_sync;
	
	output reset;
	output xclk;
	output reg write;
	output reg in_pos;
	output reg [2:0] data_out;
	
	assign reset = reset_n;
	assign xclk = clk_25;
	
	reg [9:0] r_pix;
	reg [8:0] c_pix;
	reg [2:0] byte_nr;
	
	reg increment;
	
	/* -----------------------------------------
		Paramters
	----------------------------------------- */ 
	parameter BLACK = 3'b000;
	parameter RED = 3'b100;
	parameter WHITE = 3'b111;
	parameter GREEN = 3'b010;
	parameter BLUE = 3'b001;
	
	integer Y;
	integer Cb;
	integer Cr;
	
	integer R;
	integer G;
	integer B;
	
	always @ (negedge h_ref or posedge pclk or negedge reset_n) begin
		if (!reset_n) begin
			r_pix <= 0;
			c_pix <= 0;
		end else if (!h_ref) begin
			r_pix <= 0;
			c_pix <= c_pix + 1;
		end else if (pclk && h_ref) begin
			r_pix <= r_pix + 1;
			if (c_pix == 480)
				c_pix <= 0;
		end else begin
			if (c_pix == 480)
				c_pix <= 0;
		end
	end
	
	always @ (posedge pclk or negedge reset_n) begin
		if (!reset_n) begin
			increment <= 0;
			data_out <= 0;
			byte_nr <= 0;
			in_pos <= 0;
			write <= 0;
		end else if (h_ref == 1) begin
		
			write <= 0;
		
			if (byte_nr == 0) begin
				Cb <= data_in; // Cb
				increment <= increment + 1;
			end else if (byte_nr == 1) begin
				Y <= data_in; // Y
				if (increment)
					increment <= increment + 1;
				else begin
					increment <= increment - 1;	
					R <= (Y + (Cr - 128));
					G <= (Y - 2*(Cb - 128) - 3*(Cr - 128));
					B <= (Y + 2*(Cb - 128));
					data_out <= (R > G && R > B) ? RED : (G > R && G > B) ? GREEN : BLUE;
					write <= 1;
					in_pos <= (c_pix + 1)*r_pix;
				end
			end else if (byte_nr == 2) begin
				Cr <= data_in; // Cr
				increment <= increment - 1;
				R <= (Y + (Cr - 128));
				G <= (Y - 2*(Cb - 128) - 3*(Cr - 128));
				B <= (Y + 2*(Cb - 128));
				data_out <= (R > G && R > B) ? RED : (G > R && G > B) ? GREEN : BLUE;
				write <= 1;
				in_pos <= (c_pix + 1)*r_pix;
			end
		end 
	end
endmodule