`timescale 1ns / 1ps

module freq_divider(
    input clk_in,   
    input rst, 
    input [1:0] sel,
    output reg clk_out
);

    reg [27:0] counter;
    reg [27:0] current_divisor;


    always @(*) begin
        case (sel)
            2'b00: current_divisor = 28'd50000; // 1 KHz
            2'b01: current_divisor = 28'd25000; // 2 KHz
            2'b10: current_divisor = 28'd10000; // 5 KHz
            2'b11: current_divisor = 28'd5000;  // 10 KHz
            default: current_divisor = 28'd50000; // Mặc định là 1 KHz
        endcase
    end

    // Khối chia tần số
    always @(posedge clk_in or posedge rst) begin
        if (rst) begin
            counter <= 28'd0;
            clk_out <= 1'b0;
        end else begin
            // Reset bộ đếm nếu đạt đến giá trị DIVISOR - 1
            if (counter >= (current_divisor - 1)) begin
                counter <= 28'd0;
            end else begin
                counter <= counter + 28'd1;
            end
            
            // Tạo Duty Cycle 50%
            clk_out <= (counter < (current_divisor / 2)) ? 1'b1 : 1'b0;
        end
    end

endmodule