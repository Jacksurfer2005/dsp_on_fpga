`timescale 1ns/1ns

module FIR #(
    parameter WIDTH_data  = 24,
    parameter WIDTH_coeff = 16,
    parameter WIDTH_reg   = 40, // WIDTH_data + WIDTH_coeff
    parameter TAP         = 111
) 
(
    input  wire                      clk,
    input  wire                      reset_n,
    input  wire signed [WIDTH_data-1:0] data_in,
    output wire signed [WIDTH_data-1:0] data_out
); 

// Cac mang tin hieu --- 111 taps

wire signed [WIDTH_data-1:0]  reg_in   [0:TAP-1]; // mang cho du lieu tre (delay line)
wire signed [WIDTH_reg-1:0]   mul      [0:TAP-1]; // mang cho ket qua phep nhan
wire signed [WIDTH_reg-1:0]   add_out  [0:TAP-1]; // mang cho ket qua phep cong
reg  signed [WIDTH_coeff-1:0] h        [0:TAP-1]; // mang luu gia tri he so bo loc


// Nap gia tri he so tu file hex
initial begin 
    $readmemh ("../../FIR/mem/audio_111_hex.txt", h); //nhớ tạo file coefficient từ matlab
end 

assign reg_in[0] = data_in; // gia tri dau vao khong tre

// Tao duong tre du lieu (Delay Line)
genvar i; 
generate
    for (i = 0; i < TAP - 1; i = i + 1) begin: delayfirst 
        my_DFF ff (
            .clk(clk),
            .rst_n(reset_n),
            .d_in(reg_in[i]),
            .q_out(reg_in[i+1])
        );
    end
endgenerate

// Thuc hien phep nhan (Multipliers)
genvar k; 
generate
    for (k = 0; k < TAP; k = k + 1) begin: multi_coeff
        multi mult (
            .a(reg_in[k]),
            .b(h[k]),
            .out(mul[k])
        );
    end
endgenerate

// Thuc hien chuoi cong (Adder Chain)
genvar j; 
generate
    for (j = 0; j < TAP; j = j + 1) begin: add_result 
        if (j < TAP - 1) begin : middle_add
            assign add_out[j] = mul[j] + add_out[j+1];
        end
        else begin : last_add
            assign add_out[j] = mul[j];
        end
    end
endgenerate

// Lay 24-bit cao nhat cho dau ra
assign data_out = add_out[0][WIDTH_reg-1:WIDTH_reg-24]; 
  
endmodule