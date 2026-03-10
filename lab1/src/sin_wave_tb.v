module sin_wave_tb(
);

 reg clk, rst;
 wire signed [15:0] out_wave;
 
 sin_wave dut(clk,rst,out_wave);
 
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