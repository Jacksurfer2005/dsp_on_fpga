module square_wave(
    input clk,rst,
	 output reg [7:0] square_out
);

always@(posedge clk)
  begin
    if (rst) 
			 square_out <= 8'h00;
		 
		else 
		    
		    square_out <= ~square_out;
	
	end
	
	
endmodule
		