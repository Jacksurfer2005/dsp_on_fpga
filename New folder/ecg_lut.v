module ecg_lut(
 input clk,
 input [7:0] address,
 output reg signed [15:0] data
);

 reg signed [15:0] rom [0:255];

initial begin
 $readmemh("ecg_lut.hex",rom);
  end
  
always@(posedge clk)
 begin
  data <= rom[address];
   end
	
endmodule