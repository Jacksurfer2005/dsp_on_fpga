`timescale 1ns / 1ps

module noise_freq_tb(
);

  reg clk_tb;
  reg rst_tb;
  reg [1:0] sel_tb;
  wire noise_freq_o;
 
 noise_freq dut (clk_tb,rst_tb,sel_tb,noise_freg_o);
 
 initial begin
  clk_tb = 0;
  rst_tb = 1;
   end
	
 always #10 clk_tb = ~clk_tb;
 
 initial begin
 rst_tb = 1;
 #1000000;
 
 rst_tb = 0;
 sel_tb = 2'b00;
 #1000000;
 
 sel_tb = 2'b01;
 #1000000;
 
 sel_tb = 2'b10;
 #1000000;
 
 sel_tb = 2'b11;
 #1000000;
 
end

endmodule