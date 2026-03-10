module saw_wave_tb(
);

 reg clk,rst;
 wire [15:0] out_signal;
 
 saw_wave dut(clk,rst,out_signal);
 
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
	  #200;
	  
	 end

endmodule