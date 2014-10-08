module i2c_master
(
	input	clk, in, reset,
	output reg [1:0] out
);

	// Declare state register
	reg		[3:0]state;

	// Declare states
	parameter beg = 0, ready = 1, start = 2, command = 3, s_ack = 4, wr = 5;
	parameter rd = 6, s_ack2 = 7, m_ack = 8, stop = 9;

	// Determine the next state synchronously, based on the
	// current state and the input
	always @ (posedge clk or posedge reset) begin
		if (reset)
			state <= S0;
		else
			case (state)
				S0:
					if (in)
					begin
						state <= S1;
					end
					else
					begin
						state <= S1;
					end
				S1:
					if (in)
					begin
						state <= S2;
					end
					else
					begin
						state <= S1;
					end
				S2:
					if (in)
					begin
						state <= S3;
					end
					else
					begin
						state <= S1;
					end
				S3:
					if (in)
					begin
						state <= S2;
					end
					else
					begin
						state <= S3;
					end
			endcase
	end

	// Determine the output based only on the current state
	// and the input (do not wait for a clock edge).
	always @ (state or in)
	begin
			case (state)
				S0:
					if (in)
					begin
						out = 2'b00;
					end
					else
					begin
						out = 2'b10;
					end
				S1:
					if (in)
					begin
						out = 2'b01;
					end
					else
					begin
						out = 2'b00;
					end
				S2:
					if (in)
					begin
						out = 2'b10;
					end
					else
					begin
						out = 2'b01;
					end
				S3:
					if (in)
					begin
						out = 2'b11;
					end
					else
					begin
						out = 2'b00;
					end
			endcase
	end

endmodule