module saw_wave_tb(
);

 reg clk,rst;
 reg dc;
 reg [1:0] dc_sel;
 wire [15:0] out_signal;
 
 saw_wave dut(clk,rst,dc,dc_sel,out_signal);
 
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
	  dc_sel = 2'b00
	  #200;
	  
	 end

endmodule