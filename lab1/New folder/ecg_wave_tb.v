`timescale 1ns / 1ps

module ecg_wave_tb(
);
 
 reg clk,rst;
 wire signed [15:0] wave_out;
 
 ecg_wave dut (clk,rst,wave_out);
 
 initial
  begin
   clk = 0;
	rst = 1;
	 end
	 
always #5 clk = ~clk;
 
 initial 
  begin
   rst = 1;
	#10;
	
	rst = 0;
	#100;
	end
	
endmodule
