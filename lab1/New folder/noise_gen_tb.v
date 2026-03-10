`timescale 1ns / 1ps

module noise_gen_tb(
);

 reg clk_tb;
 reg rst_tb;
 wire signed [15:0] tb_o;
 
 noise_gen dut (clk_tb,rst_tb,tb_o);
 
 initial 
  begin
 clk_tb = 0;
 rst_tb = 1;
  end
  
 always#5 clk_tb = ~clk_tb;
 
 initial
  begin
   rst_tb = 1;
	#100;
	
	rst_tb = 0;
	#10000;
	 end
	 
endmodule