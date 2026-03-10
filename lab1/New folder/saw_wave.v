module saw_wave (
 input clk,rst,
 input dc,
 input clk_en,
 input [1:0] dc_sel,
 output reg signed [15:0] saw_out
);

 reg signed [15:0] step;
 
always@(*) begin
 case (dc_sel)
   2'b00: step = 16'd2048;
	2'b01: step = 16'd1024;
	2'b10: step = 16'd512;
	2'b11: step = 16'd341;
	 endcase
end


always@(posedge clk )
 begin
  if (rst) 
     saw_out <= -16'sd32768;
  else if (clk_en) begin 
   if (dc)
     saw_out <= saw_out + step;
	 else
	  saw_out <= -16'sd32768;
 end
 end
 
endmodule