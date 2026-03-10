`timescale 1ns / 1ps

module sq_wave_tb (
);

 reg clk,rst;
 reg [1:0] dc;
 wire level;
 wire signed [15:0] sq_out;
 
square_wave dut (clk,rst,dc,level,sq_out);

 initial 
  begin
   clk = 0;
   rst = 1;
    end
	
always #5 clk = ~clk;

 initial 
  begin
   rst = 1;
	dc = 2'b00;
   #15;
	
	rst =0;
	end
	
 initial
  begin
   dc = 2'b01;
	#6000;
	dc = 2'b10;
	#6000;
	dc = 2'b11;
	#6000;
	dc = 2'b00;
	#6000;
	 end
	 
endmodule

   	