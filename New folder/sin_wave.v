`timescale 1ns / 1ps

module sin_wave (
 input clk, rst,
 input clk_en,
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
  else if (clk_en)
   addr <= addr + 1'b1;
end

endmodule