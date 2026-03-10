module count_addr_RAM (
   input clk,
   input reset_n,
   output reg [15:0] addr
);

always @(posedge clk or negedge reset_n) begin
   if(!reset_n)
      addr <= 16'd0;
   else begin
      if (addr < 1000)
         addr <= addr + 16'd1;
      else
         addr <= 16'd0;
   end
end

endmodule