module trig_wave(
 input clk,rst,
 input dc,
 input clk_en,
 input [1:0] dc_sel,
 output reg signed [15:0] trig_out
);

 reg signed [15:0] step_up;
 reg signed [15:0] step_down;

always@(*) begin
 case (dc_sel)
   2'b00: step_up = 16'd2048;
	2'b01: step_up = 16'd1024;
	2'b10: step_up = 16'd512;
	2'b11: step_up = 16'd341;
	 endcase
end

always@(*) begin
 case (dc_sel)
   2'b00: step_down = 16'd292;
	2'b01: step_down = 16'd341;
	2'b10: step_down = 16'd512;
	2'b11: step_down = 16'd1024;
	 endcase
end
  
always@(posedge clk) 
 begin
  if (rst) 
	 trig_out <= -16'sd32768;
  else if (clk_en) begin
   if (dc) begin
	 if (trig_out > 16'sd32767 - step_up)
	     trig_out <= 16'sd32767;
	 else 
	     trig_out <= trig_out + step_up;
	  end else begin
	   if (trig_out < -16'sd32768 + step_down)
		  trig_out <= -16'sd32768;
	   else
	     trig_out <= trig_out - step_down;
     end
	  end
end

   
endmodule