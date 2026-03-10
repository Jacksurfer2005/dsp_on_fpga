`timescale 1ns / 1ps

module top_wave_tb();
    reg clk;
    reg rst;
    reg [1:0] dc_in_tb;
	 reg [1:0] sel_tb;
	 reg [2:0] sel_wave_tb;

    wire signed [15:0] test_o;    

    top_wave dut (
        .clk        (clk),
        .rst        (rst),
        .dc         (dc_in_tb),
        .sel        (sel_tb),
		  .sel_wave   (sel_wave_tb),
		  .wave_final (test_o)
        
    );

   
    initial
	  begin 
	    clk = 0;
		 rst = 1;
		  end
		  
    always #10 clk = ~clk;

    initial begin
        
        rst = 1;
        dc_in_tb = 1;     
        sel_tb = 2'b00;    
        #100 
		  
		  rst = 0;  
		  sel_wave_tb = 3'b000; 
		  sel_tb = 2'b10; 
        dc_in_tb = 2'b10; 
        #10000000;
		  
		  sel_wave_tb  = 3'b001;
        sel_tb = 2'b10;
		  dc_in_tb = 2'b01;
        #10000000;
		  
		  sel_wave_tb = 3'b010;
		  sel_tb = 2'b11;
		  dc_in_tb = 2'b11;
		  #10000000;
		  
		  sel_wave_tb = 3'b011;
		  sel_tb = 2'b11;
		  dc_in_tb = 2'b11;
		  #10000000;
		  
		  sel_wave_tb = 3'b100;
		  sel_tb = 2'b11;
		  dc_in_tb = 2'b11;
		  #10000000;



        
    end

endmodule