`timescale 1ns / 1ps

module wave_wrapper_tb(
);

 reg clk,rst;
 reg enable;
 reg [2:0] wave_in_wrapper_tb;
 reg [2:0] amp_wrapper_tb;
 reg [1:0] dc_wrapper_tb;
 reg [1:0] noise_sel_tb; 
 reg [2:0] noise_amp_tb;
 reg [1:0] sel_f_wrapper_tb;
 
 wire signed [23:0] wave_in_tb;
 wire signed [23:0] noise_in_tb;
 wire signed [23:0] wave_wrapper_tb;
 
  wave_wrapper dut (
    .clk              (clk),
    .rst              (rst),
    .enable           (enable),
    .wave_in          (wave_in_tb),
	 .noise_in         (noise_in_tb),
	 .wave_in_wrapper  (wave_in_wrapper_tb),
	 .amp_wrapper      (amp_wrapper_tb),
	 .dc_wrapper       (dc_wrapper_tb),
	 .sel_f_wrapper    (sel_f_wrapper_tb),
	 .noise_sel        (noise_sel_tb), 
	 .noise_amp        (noise_amp_tb),
	 .wave_wrapper     (wave_wrapper_tb)
);
  
  
 initial 
  begin
   clk = 0;
	rst = 1;
	enable = 1;
	 end
	 
 always#10 clk = ~clk;
 
 initial
  begin
   rst = 1;
	#40;
	
	rst = 0;
	enable = 1;
	wave_in_wrapper_tb = 3'b100;
	sel_f_wrapper_tb   = 2'b10;
	amp_wrapper_tb     = 3'b000;
	noise_sel_tb       = 2'b11;
	noise_amp_tb       = 3'b00;
	#1000000;
	
	enable = 1;
	wave_in_wrapper_tb = 3'b100;
	sel_f_wrapper_tb   = 2'b01;
	amp_wrapper_tb = 3'b001;
	noise_sel_tb   = 2'b11;
	noise_amp_tb   = 3'b00;
	#1000000;
	
	enable = 1;
	wave_in_wrapper_tb = 3'b100;
	sel_f_wrapper_tb   = 2'b11;
	amp_wrapper_tb = 3'b010;
	noise_sel_tb   = 2'b11;
	noise_amp_tb   = 3'b00;
	#1000000;
	  
	enable = 0;
	wave_in_wrapper_tb = 3'b100;
	sel_f_wrapper_tb   = 2'b10;
	amp_wrapper_tb = 3'b010;
	noise_sel_tb   = 2'b11;
	noise_amp_tb   = 3'b000;
	#1000000;
	
	enable = 0;
	wave_in_wrapper_tb = 3'b100;
	sel_f_wrapper_tb   = 2'b11;
	amp_wrapper_tb = 3'b010;
	noise_sel_tb   = 2'b11;
	noise_amp_tb   = 3'b010;
	#1000000;
	  end 
	  
endmodule