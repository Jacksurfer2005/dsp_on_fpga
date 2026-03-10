`timescale 1ns/1ns

module fir_filter (
    input  wire        clk,
    input  wire        reset_n,
    input  wire [3:0]  is_key_config,
    input  wire [9:0]  sw,

    output wire        bclk,
    output wire        serial_data,
    output wire        xck,
    output wire        daclrck,
    output wire        sclk,
    output wire        sdin,
    output wire [9:0]  led_red
);

    // Cac tin hieu dieu khien xung nhip
    wire clk_12M, clk_400K, clk_sample;
    
    // Cac bus du lieu
    reg  [23:0] gain_coeff; // Dung reg vi duoc gan trong khoi always
    wire [23:0] data_send_filter, data_filterd, data_filter_amp, data_osc;
    
    wire [15:0] addr_RAM;
    wire        done_config;

    // Gan xung nhip he thong cho xck cua codec
    assign xck = clk_12M;
    
    // Khoi tao bo chia xung nhip 400KHz cho I2C
    clk_400K clock_gen_400K (
        .clk_in  (clk),
        .reset_n (reset_n),
        .clk_out (clk_400K)
    );

    // Khoi tao bo chia xung nhip 12MHz cho Audio Codec
    clk_12M clock_gen_12M (
        .clk_in  (clk),
        .reset_n (reset_n),
        .clk_out (clk_12M)
    );

    // RAM chua du lieu am thanh dau vao
    single_port_RAM data_in_RAM (
        .clk    (clk_sample),
        .cs     (1'b1),
        .we     (1'b0), // Che do doc
        .addr   (addr_RAM),
        .w_data (24'd0),
        .r_data (data_send_filter)
    );

    // Khoi khuech dai tin hieu (Gain)
    gain gain_amp (
        .data_in    (data_filterd),
        .gain_coeff (gain_coeff),
        .data_out   (data_filter_amp)
    );

    // Chon lua tin hieu dau ra dua tren Switch 0
    assign data_osc = (sw[0]) ? data_filter_amp : 24'd0;

    // Thiet lap he so khuech dai (gain x1024)
    // Su dung always thay cho always_ff trong SystemVerilog
    always @(posedge is_key_config[2] or negedge reset_n) begin 
        if (~reset_n) 
            gain_coeff <= 24'h000400;
        else          
            gain_coeff <= 24'h000400;
    end 
    
    // Cau hinh chip Audio Codec qua giao tiep I2C
    audio_codec codec (
        .clk_i2c    (clk_400K),
        .reset_n    (reset_n),
        .is_config  (is_key_config[1]),
        .sclk       (sclk),
        .sdin       (sdin),
        .done       (done_config)
    );

    // Chuyen doi du lieu song song sang noi tiep (I2S format)
    paralell_serial p2s (
        .clk_12M       (clk_12M),
        .start         (done_config),
        .data_paralell (data_osc),
        .bclk          (bclk),
        .lrclk         (daclrck),
        .clk_fsample   (clk_sample),
        .data_serial   (serial_data)
    );

endmodule