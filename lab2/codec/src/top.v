module top (
   input clk,
   input reset_n,
   input [3:0] is_key_config,
   input [9:0] sw,

   output bclk,
   output serial_data,
   output xck,
   output daclrck,
   output sclk,
   output sdin,
   output [9:0] led_red
);

wire clk_12M;
wire clk_400K;
wire clk_sample;

reg  [23:0] gain_coeff;

wire [23:0] data_send_filter;
wire [23:0] data_filterd;
wire [23:0] data_filter_amp;
wire [23:0] data_osc;

wire [15:0] addr_RAM;
wire done_config;

assign xck = clk_12M;

clk_400K clock_gen_400K (
   .clk_in  (clk),
   .reset_n (reset_n),
   .clk_out (clk_400K)
);

clk_12M clock_gen_12M (
   .clk_in  (clk),
   .reset_n (reset_n),
   .clk_out (clk_12M)
);

single_port_RAM data_in_RAM (
   .clk    (clk_sample),
   .cs     (1'b1),
   .we     (1'b0),
   .addr   (addr_RAM),
   .w_data (24'd0),
   .r_data (data_send_filter)
);

count_addr_RAM count_addr (
   .clk     (clk_sample),
   .reset_n (reset_n),
   .addr    (addr_RAM)
);

gain gain_amp (
   .data_in    (data_filterd),
   .gain_coeff (gain_coeff),
   .data_out   (data_filter_amp)
);

assign data_osc = (sw[0]) ? data_filter_amp : 24'd0;

// gain x1024
always @(posedge is_key_config[2] or negedge reset_n) begin
   if (~reset_n)
      gain_coeff <= 24'h000400;
   else
      gain_coeff <= 24'h000400;
end

audio_codec codec (
   .clk_i2c   (clk_400K),
   .reset_n   (reset_n),
   .is_config (is_key_config[1]),
   .sclk      (sclk),
   .sdin      (sdin),
   .done      (done_config)
);

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