module test (
    input clk,
    input rst,
    input [1:0] dc,      
    input dc_in,         
    input [1:0] sel,     
    output level,        
    output signed [15:0] square_out,
    output signed [15:0] saw_out,
    output signed [15:0] trig_out,
    output signed [15:0] sin_out,
    output signed [15:0] ecg_out
);

    wire clk_en_wire; 

    // 1. Bộ chia tần số chung
    freq_divider u_freq_divider (
        .clk_in (clk),
        .rst    (rst),
        .sel    (sel),
        .clk_en (clk_en_wire)
    );

    // 2. Module sóng Vuông
    square_wave u_square_wave (
        .clk        (clk),
        .rst        (rst),
        .dc         (dc),
        .clk_en     (clk_en_wire),
        .level      (level),
        .square_out (square_out)
    );

    // 3. Module sóng Răng cưa
    saw_wave u_saw_wave (
        .clk     (clk),
        .rst     (rst),
        .dc      (dc_in),
        .dc_sel  (dc),
        .clk_en  (clk_en_wire),
        .saw_out (saw_out)
    );

    // 4. Module sóng Tam giác
    trig_wave u_trig_wave (
        .clk      (clk),
        .rst      (rst),
        .clk_en   (clk_en_wire),
        .dc       (dc_in),
        .dc_sel   (dc),
        .trig_out (trig_out)
    );

    // 5. Module sóng Sin
    sin_wave u_sin_wave (
        .clk     (clk),
        .rst     (rst),
        .clk_en  (clk_en_wire),
        .sin_out (sin_out)
    );

    // 6. Module sóng ECG
    ecg_wave u_ecg_wave (
        .clk     (clk),
        .rst     (rst),
        .clk_en  (clk_en_wire), 
        .ecg_out (ecg_out)
    );

endmodule