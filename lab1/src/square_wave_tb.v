module sq_wave_tb (
);
    reg clk,rst;
	 wire [7:0] out_signal;
	 
	 square_wave dut(clk,rst,out_signal);
	 
	 initial
	    begin 
		    clk = 0;
			 rst = 1;
		 end
		 
	 always #5 clk = ~clk;
	 
	 initial 
	    begin
		  rst=1;
		  #0;
		  
		  rst=0;
		  #100;
		  
		  end
endmodule