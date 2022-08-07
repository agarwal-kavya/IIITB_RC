`timescale 1ns/1ps
module iiitb_rc_tb;
	reg clk;
	reg ori;
	wire[3:0] count;
	iiitb_rc rc(clk, ori, count);
	initial
	begin
		clk = 0;
		ori = 0;
	end
	always
	begin
		#10;
		clk = ~clk;
	end
	initial
	begin
		$dumpfile("iiitb_rc_out.vcd");
		$dumpvars(0, iiitb_rc_tb);
		ori = 1;
		#50;
		ori = 0;
	end
endmodule
