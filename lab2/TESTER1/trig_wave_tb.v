module trig_wave_tb(
);

 reg clk,rst;
 wire [15:0] signal_out;
 reg [7:0] top,bottom;
 
 trig_wave dut(clk,rst,top,bottom,signal_out);
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
	 top = 8'd192;
	 bottom = 8'd64;
	 #15;
	 
	 top = 8'd64;
	 bottom = 8'd192;
	 #30;
	end
	
endmodule
 
 