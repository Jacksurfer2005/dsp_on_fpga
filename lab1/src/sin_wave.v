module sin_wave (
 input clk, rst,
 output signed [15:0] sin_out
);

 reg [7:0] addr;
 
 sin_lut u_sin_lut(
  .clk   (clk),
  .address (addr),
  .data    (sin_out)
);
 
always@(posedge clk)
 begin
  if (rst) 
   addr <= 8'h00;
 else 
   addr <= addr + 1'b1;
end

endmodule