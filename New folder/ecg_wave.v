module ecg_wave(
 input clk, rst,
 input clk_en,
 output signed [15:0] ecg_out
);

 reg [7:0] addr;
 
 ecg_lut u_ecg_lut(clk, addr, ecg_out); 
 
always@(posedge clk)
 begin
  if (rst)
   addr <= 8'h00;
  else if (clk_en) 
   addr <= addr + 1'b1;
 end
	 
endmodule