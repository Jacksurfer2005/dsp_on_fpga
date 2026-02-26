`timescale 1ns / 1ps

module sin_lut(
 input clk,
 input [7:0] address,
 output reg signed [15:0] data
);

 reg signed [15:0] rom [0:255];
 
initial begin
 $readmemh("sin_lut.hex",rom);
  end
 
always@(posedge clk)
begin
 data <= rom[address];
end

endmodule