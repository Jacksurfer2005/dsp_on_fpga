module square_wave(
    input clk,rst,
	 input [1:0] dc,
	 input clk_en,
	 output reg level,
	 output reg signed [15:0] square_out
);

   
	reg [7:0] counter;
   reg [7:0] dc_max;
always@(*)
  begin
    case (dc)
	  2'b00 : dc_max = 8'd32 ;  // (12.5)
	  2'b01 : dc_max = 8'd64 ;  // (25)
	  2'b10 : dc_max = 8'd128;  // (50)
	  2'b11 : dc_max = 8'd192;  // (75)
	endcase
end

always@(posedge clk)
  begin
    if (rst) 
	       counter <= 8'd0;
	 else if (clk_en)
          counter <= counter + 1'b1;
  end

always@(posedge clk)
  begin
    level <= (counter < dc_max);
	
			
		 if (counter < dc_max)
		    square_out <= 16'sd32767;
		 else 
		    square_out <= -16'sd32768;	  		  
		   end
endmodule