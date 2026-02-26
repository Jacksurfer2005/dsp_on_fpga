module saw_wave (
 input clk,rst,
 input clk_en,
 input dc,
 input [1:0] dc_sel,
 output reg signed [15:0] saw_out
);

 reg signed [15:0] step;
 
always@(*) begin
 case (dc_sel)
   2'b00: step = 16'd2048;
	2'b01: step = 16'd1024;
	2'b10: step = 16'd512;
	2'b11: step = 16'd341;
	 endcase
end

always@(posedge clk )
 begin
  if (rst) 
     saw_out <= -16'sd32768;
  else if (clk_en) begin
     // Khi clk_en = 1, module mới bắt đầu tạo sóng dựa trên tín hiệu dc
     if (dc)
        saw_out <= saw_out + step; 
     else
        saw_out <= -16'sd32768;
  end
  // Nếu clk_en = 0, saw_out sẽ tự động giữ nguyên giá trị hiện tại (không tăng, không reset)
 end
 
endmodule