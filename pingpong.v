`timescale 1ns / 1ps

module pingpong(clk, rst_n, out, hold, flip, dir, max, min);
	input clk;
	input rst_n;
	input hold;
	input flip;
	output [3:0] out;
	output dir;
	output max;
	output min;
	reg [3:0] counter = 4'b0000;
	reg dir = 1'b0;
	
	always @ (posedge clk, negedge rst_n) begin
		if (rst_n == 0) begin
			counter <= 4'b0000;
			dir <= 0;
		end

		else if (hold == 1) begin
			counter <= counter; //hold
		end

		else begin
			if (flip == 1) begin
				if (counter != 4'b0001 && counter != 4'b1110) begin 
					dir <= ~dir; //flip
				end
			end

			if (dir == 1'b0) begin
				counter <= counter + 1; //++
				if (counter == 4'b1110) begin
					dir <= ~dir;
				end
			end

			else if (dir == 1'b1) begin
				counter <= counter - 1; //--
				if (counter == 4'b0001) begin
					dir <= ~dir;
				end
			end
		end
	end
	
	assign max = (counter == 4'b1111) ? 1 : 0;
	assign min = (counter == 4'b0000) ? 1 : 0;
	assign out = counter;
endmodule
