module noise_freq(
 input clk_i,
 input rst_i,
 input [1:0] sel_i,
 output reg en_f
);

reg [15:0] div_value; 
reg [15:0] counter;

always@(*) begin
  case(sel_i)
     2'b00: div_value = 16'd2500; //  10KHz
	  2'b01: div_value = 16'd500; // 50KHz
	  2'b10: div_value = 16'd250; // 100KHz
	  2'b11: div_value = 16'd125;  // 200KHz
	  default: div_value = 16'd2500;
	    endcase
end

always@(posedge clk_i) begin
 if (rst_i) begin
     counter <= 16'd0;
	  en_f <= 0;
 end else if (counter == div_value - 1) begin
     counter <= 16'd0;
	  en_f <= 1;
 end 
  else begin
     counter <= counter + 1'b1;
	  en_f <= 0;
 end
  end

endmodule