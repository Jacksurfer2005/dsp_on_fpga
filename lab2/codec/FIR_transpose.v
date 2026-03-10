`timescale 1ns/1ns

module FIR_transpose #(
    parameter   WIDTH_data =  24,
    parameter   WIDTH_coeff = 16,
    parameter   TAP =         111,
    parameter   WIDTH_reg =   40 
) 
(
    input  wire                            clk,
    input  wire                            reset_n,
    input  wire signed [WIDTH_data-1:0]    data_in,
    output wire signed [WIDTH_data-1:0]    data_out
);

    wire signed [WIDTH_reg-1:0]    delay      [0:TAP-1]; // mang du lieu tre
    wire signed [WIDTH_reg-1:0]    mul        [0:TAP-1]; // mang ket qua phep nhan
    wire signed [WIDTH_reg-1:0]    add_out    [0:TAP-1]; // mang ket qua phep cong
    reg  signed [WIDTH_coeff-1:0]  h          [0:TAP-1];

    initial begin 
        $readmemh ("E:/Lecture/DSPonFPGA/FIR/mem/audio_111_hex.txt", h);
    end 

    assign delay[0] = 40'd0;

    genvar i;
    generate 
        for (i=0; i < TAP; i = i + 1) begin: multi_datain_coeff 
            multi mult (
                .a(data_in),
                .b(h[i]),
                .out(mul[i])
            );
        end
    endgenerate 

    genvar k;
    generate 
        for (k=0; k < TAP; k = k + 1) begin: adder
            assign add_out[k] = mul[k] + delay[k];
        end
    endgenerate 

    genvar j;
    generate 
        for (j=0; j < TAP - 1; j = j + 1) begin: delay_ztr1
            my_DFF_40 element (
                .rst_n(reset_n),
                .clk(clk),
                .d_in(add_out[j]),
                .q_out(delay[j+1])
            );
        end
    endgenerate
    
    assign data_out = add_out[TAP-1][WIDTH_reg-1:WIDTH_reg-24];

endmodule