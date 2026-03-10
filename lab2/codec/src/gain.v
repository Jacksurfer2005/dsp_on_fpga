module gain (
   input  wire signed [23:0] data_in     ,
   input  wire signed [23:0] gain_coeff  ,
   
   output wire signed [23:0] data_out
);
   wire signed [47:0] mul_temp;

   assign mul_temp = data_in * gain_coeff;
   assign data_out = data_in; // Luu y: Theo code goc ban dang gan thang data_in vao output

endmodule