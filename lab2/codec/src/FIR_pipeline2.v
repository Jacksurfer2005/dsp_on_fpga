`timescale 1ps/1ps

module FIR_pipeline2 #(
    parameter   WIDTH_data = 24,
    parameter   WIDTH_data_out = 48,
    parameter   WIDTH_coeff = 16,
    parameter   WIDTH_reg = 40, // WIDTH_data + WIDTH_coeff
    parameter   TAP = 52
) 
(
    input  wire                          clk,
    input  wire                          reset_n,
    input  wire signed [WIDTH_data-1:0]  data_in,
    output wire signed [WIDTH_data-1:0]  data_out
);

    wire signed [WIDTH_reg-1:0] delay    [0:TAP-1]; // mang cho du lieu tre
    wire signed [WIDTH_reg-1:0] pipeline [0:TAP-1]; // mang pipeline
    wire signed [WIDTH_reg-1:0] mul      [0:TAP-1]; // mang ket qua phep nhan
    wire signed [WIDTH_reg-1:0] add_out  [0:TAP-1]; // mang ket qua phep cong
    reg  signed [WIDTH_coeff-1:0] h      [0:TAP-1]; // mang luu he so

    // Khoi tao he so (Gan tung gia tri cho phu hop voi Verilog 2001)
    initial begin
        h[0]  = 16'hFFEC; h[1]  = 16'hFFDD; h[2]  = 16'hFFDD; h[3]  = 16'hFFF0;
        h[4]  = 16'h0019; h[5]  = 16'h004A; h[6]  = 16'h0068; h[7]  = 16'h004E;
        h[8]  = 16'hFFEF; h[9]  = 16'hFF66; h[10] = 16'hFEFC; h[11] = 16'hFF06;
        h[12] = 16'hFFB7; h[13] = 16'h00E6; h[14] = 16'h020B; h[15] = 16'h0269;
        h[16] = 16'h0170; h[17] = 16'hFF2A; h[18] = 16'hFC68; h[19] = 16'hFA9E;
        h[20] = 16'hFB54; h[21] = 16'hFF76; h[22] = 16'h06BF; h[23] = 16'h0FA1;
        h[24] = 16'h17AC; h[25] = 16'h1C74; h[26] = 16'h1C74; h[27] = 16'h17AC;
        h[28] = 16'h0FA1; h[29] = 16'h06BF; h[30] = 16'hFF76; h[31] = 16'hFB54;
        h[32] = 16'hFA9E; h[33] = 16'hFC68; h[34] = 16'hFF2A; h[35] = 16'h0170;
        h[36] = 16'h0269; h[37] = 16'h020B; h[38] = 16'h00E6; h[39] = 16'hFFB7;
        h[40] = 16'hFF06; h[41] = 16'hFEFC; h[42] = 16'hFF66; h[43] = 16'hFFEF;
        h[44] = 16'h004E; h[45] = 16'h0068; h[46] = 16'h004A; h[47] = 16'h0019;
        h[48] = 16'hFFF0; h[49] = 16'hFFDD; h[50] = 16'hFFDD; h[51] = 16'hFFEC;
    end

    assign delay[0] = 40'd0; 

    genvar i;
    generate 
        for (i = 0; i < TAP; i = i + 1) begin: multi_datain_coeff 
            multi mult (
                .a(data_in),
                .b(h[i]),
                .out(mul[i])
            );
        end
    endgenerate 

    genvar p;
    generate 
        for (p = 0; p < TAP; p = p + 1) begin: pipeline_stage
            my_DFF_40 delay_e (
                .clk(clk),
                .rst_n(reset_n),
                .d_in(mul[p]),
                .q_out(pipeline[p])
            );
        end
    endgenerate 

    genvar k;
    generate 
        for (k=0; k < TAP; k = k + 1) begin: adder
            assign add_out[k] = pipeline[k] + delay[k];
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

    assign data_out = add_out[TAP-1][39:16];

endmodule