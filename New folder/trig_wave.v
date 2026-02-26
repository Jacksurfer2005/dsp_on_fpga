module trig_wave(
 input clk, rst,
 input clk_en,
 input dc,     
 input [1:0] dc_sel,
 output reg signed [15:0] trig_out
);

 reg signed [15:0] step_up;
 reg signed [15:0] step_down;
 reg dir; // Cờ chỉ hướng: 1 = Đang đi lên (Up), 0 = Đang đi xuống (Down)

// Chọn bước nhảy LÊN
always@(*) begin
 case (dc_sel)
   2'b00: step_up = 16'd2048;
   2'b01: step_up = 16'd1024;
   2'b10: step_up = 16'd512;
   2'b11: step_up = 16'd341;
 endcase
end

// Chọn bước nhảy XUỐNG
always@(*) begin
 case (dc_sel)
   2'b00: step_down = 16'd292;
   2'b01: step_down = 16'd341;
   2'b10: step_down = 16'd512;
   2'b11: step_down = 16'd1024;
 endcase
end
  
always@(posedge clk) begin
  if (rst) begin
     trig_out <= -16'sd32768;
     dir <= 1'b1; // Mặc định bắt đầu bằng việc đi lên
  end 
  else if (clk_en) begin
     if (dc) begin // Nếu được phép chạy
        
        if (dir == 1'b1) begin // TRẠNG THÁI ĐI LÊN
           if (trig_out >= 16'sd32767 - step_up) begin
              trig_out <= 16'sd32767;
              dir <= 1'b0; // Chạm đỉnh -> Đảo cờ sang đi xuống
           end else begin
              trig_out <= trig_out + step_up;
           end
        end 
        
        else begin // TRẠNG THÁI ĐI XUỐNG
           if (trig_out <= -16'sd32768 + step_down) begin
              trig_out <= -16'sd32768;
              dir <= 1'b1; // Chạm đáy -> Đảo cờ sang đi lên
           end else begin
              trig_out <= trig_out - step_down;
           end
        end

     end else begin // Nếu dc = 0 (Không cho phép chạy)
        trig_out <= -16'sd32768; // Reset về đáy
        dir <= 1'b1;             // Reset cờ hướng
     end
  end
end

endmodule