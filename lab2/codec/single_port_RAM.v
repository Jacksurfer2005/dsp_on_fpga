`timescale 10ns/1ps

module single_port_RAM #(
   parameter A_WIDTH = 16,
   parameter DEPTH = 1 << A_WIDTH,
   parameter D_WIDTH = 24
)(
   input clk,
   input cs,
   input we,
   input [A_WIDTH-1:0] addr,
   input [D_WIDTH-1:0] w_data,
   output reg [D_WIDTH-1:0] r_data
);

reg [D_WIDTH-1:0] RAM [0:DEPTH-1];

initial begin
   $display ("load data from text file ...");
   $readmemh("../samples/sine.hex", RAM);
   $display ("completed");
end

always @(posedge clk) begin
   if (cs) begin
      if (we)
         RAM[addr] <= w_data;
      else
         r_data <= RAM[addr];
   end
end

endmodule