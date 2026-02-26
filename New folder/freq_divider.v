`timescale 1ns / 1ps

module freq_divider(
    input clk_in,   
    input rst, 
    input [1:0] sel,
    output reg clk_en
);

    reg [7:0] counter;
    reg [7:0] current_divisor;


    always @(*) begin
        case (sel)
            2'b00: current_divisor = 8'd195; // 1 KHz
            2'b01: current_divisor = 8'd39; // 5 KHz
            2'b10: current_divisor = 8'd4; // 50 KHz
            2'b11: current_divisor = 8'd2;  // 100 KHz
            default: current_divisor = 8'd195; // Mặc định là 1 KHz
        endcase
    end

    // Khối chia tần số
    always @(posedge clk_in or posedge rst) begin
        if (rst) begin
            counter <= 8'd0;
            clk_en <= 0;
        end else begin
            if (counter == (current_divisor - 1)) begin
                counter <= 8'd0;
					 clk_en <= 1;
            end else begin
                counter <= counter + 1'd1;
					 clk_en <=0;
				end 
            end
    end

endmodule