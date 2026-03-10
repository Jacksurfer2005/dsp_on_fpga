module noise_gen(
  input clk_g,
  input rst_i,
  input en_g,
  output reg signed [15:0] gen_o
);

 wire feedback;

 assign feedback = gen_o[15] ^
                   gen_o[13] ^
			 		    gen_o[12] ^
			          gen_o[10];

always@(posedge clk_g) 
 begin
  if (rst_i)
      gen_o <= 16'b1010110100111000;
  else if (en_g)
      gen_o <= {feedback,gen_o[15:1]};
	 end
	
endmodule	
      
					  