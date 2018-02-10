`timescale 1ns / 1ps

module pingpong_t;
	reg rst_n, hold, flip;
	reg clk;
	wire [3:0] out;
	wire max, min;
	wire dir;

	pingpong pp(clk, rst_n, out, hold, flip, dir, max, min);

	initial begin 
		clk <= 0;
		rst_n <= 1;
		hold <= 0;
		flip <= 0;
		$monitor("%g\t clk=%b\t rst_n=%b\t out=%4b\t hold=%b\t flip=%b\t dir=%b\t max=%b\t min=%b\t)",
			$time, clk, rst_n, out, hold, flip, dir, max, min);
		$fsdbDumpfile("pingpong.fsdb");
		$fsdbDumpvars;
		
		#28 flip <= ~flip;
		#5 flip <= ~flip;
		#20 hold <= ~hold;
		#3 hold <= ~hold;
		#6 rst_n <= ~rst_n;
		#5 rst_n <= ~rst_n;
		#10 rst_n <= ~rst_n;
			flip <= ~flip;
			hold <= ~hold;
		#5 rst_n <= ~rst_n;
		#20 $finish;
	end

	always begin
		#1 clk <= ~clk;
	end
endmodule
