`timescale 1ns/1ns
module FIR_pipeline3 #(
    parameter WIDTH_data =  24,
    parameter WIDTH_coeff = 16,
    parameter TAP =         111,
    parameter WIDTH_reg =   40 // WIDTH_data + WIDTH_coeff 
) 
(
    input  wire                            clk,
    input  wire                            reset_n,
    input  wire signed [WIDTH_data-1:0]    data_in,
    output wire signed [WIDTH_data-1:0]    data_out
);

    wire signed [WIDTH_reg-1:0] mul        [0:TAP-1]; // mang ket qua phep nhan
    wire signed [WIDTH_reg-1:0] delay      [0:TAP-1]; // mang tre cho pipeline stage 1
    wire signed [WIDTH_reg-1:0] reg_pipe1  [0:TAP-1]; // mang pipeline stage 1
    wire signed [WIDTH_reg-1:0] reg_pipe2  [0:TAP-1]; // mang pipeline stage 2
    wire signed [WIDTH_reg-1:0] add_result [0:TAP-1]; // mang ket qua phep cong
    wire signed [WIDTH_reg-1:0] reg_in     [0:TAP-1]; // mang luu du lieu vao
    reg  signed [WIDTH_coeff-1:0] h        [0:TAP-1]; // he so bo loc lowpass 1KHZ

    assign delay[0] = 40'd0;

    initial begin 
        $readmemh ("../../FIR/mem/audio_111_hex.txt", h);
    end 

    genvar q;
    generate
        for (q = 0; q < TAP; q = q + 1) begin: store_data_in 
           assign reg_in[q] = data_in;
        end
    endgenerate

    genvar i; 
    generate
        for (i = 0; i < TAP; i = i + 1) begin: pipeline1 
            my_DFF dff1 (
                .clk(clk),
                .rst_n(reset_n),
                .d_in(reg_in[i][WIDTH_data-1:0]),
                .q_out(reg_pipe1[i][WIDTH_data-1:0])
            );
        end
    endgenerate

    genvar k; 
    generate
        for (k = 0; k < TAP; k = k + 1) begin: multi
            multi mult (
                .a(reg_pipe1[k][WIDTH_data-1:0]),
                .b(h[k]),
                .out(mul[k])
            );
        end
    endgenerate

    genvar e; 
    generate
        for (e = 0; e < TAP; e = e + 1) begin: pipeline2 
            my_DFF_40 dff2 (
                .clk(clk),
                .rst_n(reset_n),
                .d_in(mul[e]),
                .q_out(reg_pipe2[e])
            );
        end
    endgenerate

    genvar p;
    generate
        for (p = 0; p < TAP-1; p = p + 1) begin: delay_ff 
            my_DFF_40 delayf (
                .clk(clk),
                .rst_n(reset_n),
                .d_in(add_result[p]),
                .q_out(delay[p+1])
            );
        end
    endgenerate

    genvar j; 
    generate
        for (j = 0; j < TAP; j = j + 1) begin: result
            assign add_result[j] = reg_pipe2[j] + delay[j];
        end
    endgenerate

    assign data_out = add_result[TAP-1][WIDTH_reg-1:WIDTH_reg-24]; 
  
endmodule