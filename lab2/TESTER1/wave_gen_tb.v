`timescale 1ns / 1ps

module wave_gen_tb(
);

 reg clk,rst;
 reg [1:0] sel_f_tb;
 reg [2:0] amp_sel_tb;
 reg [1:0] dc_sel_tb;
 reg [2:0] sel_wave_tb;
 wire signed [23:0] gen_out_tb;
 
wave_gen dut (clk,rst,sel_f_tb,dc_sel_tb,amp_sel_tb,sel_wave_tb,gen_out_tb);

 initial begin
  clk = 0;
  rst = 1;
   end
	
 always #5 clk = ~clk;
 
 initial begin
  rst = 1;
  #10;
  
  rst = 0;
  sel_f_tb     = 2'b10;
  sel_wave_tb  = 3'b001;
  amp_sel_tb   = 3'b001;
  dc_sel_tb    = 2'b10;
  #2000000;
  
  sel_f_tb     = 2'b10;
  sel_wave_tb  = 3'b010;
  amp_sel_tb   = 3'b001;
  dc_sel_tb    = 2'b10;
  #2000000;
  
  sel_f_tb     = 2'b10;
  sel_wave_tb  = 3'b011;
  amp_sel_tb   = 3'b001;
  dc_sel_tb    = 2'b10;
  #2000000;
  
  sel_f_tb     = 2'b10;
  sel_wave_tb  = 3'b100;
  amp_sel_tb   = 3'b001;
  dc_sel_tb    = 2'b10;
  #2000000;
  
  sel_f_tb     = 2'b10;
  sel_wave_tb  = 3'b100;
  amp_sel_tb   = 3'b010;
  dc_sel_tb    = 2'b10;
  #2000000;
  end
  
  
endmodule

