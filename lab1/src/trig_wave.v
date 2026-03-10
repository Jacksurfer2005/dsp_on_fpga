module trig_wave(
 input clk,rst,
 input  [7:0] max_value,
 input  [7:0] min_value,
 output [15:0] trig_out
);

 reg [7:0] counter;
 reg direc;
 
always@(posedge clk) 
 begin
  if (rst) begin
   
	counter <= 8'h00;
	direc   <= 1'b1;
 end else begin 
  if (direc) begin
      counter <= counter + 1'b1;		
	 if ( counter == max_value - 1'b1) 
	   direc <= 1'b0;
		 end
	 else begin
	   counter <= counter - 1'b1;
		  if ( counter == min_value - 1'b1) 
		    direc <= 1'b1;
			  end 
				 end
				 end


  assign trig_out = counter << 8;
   
endmodule