module wave_gen(
 input clk,rst,
 input [1:0] sel_f,
 input [1:0] dc_sel,
 input [2:0] amp_sel,
 input [2:0] sel_wave,
 output signed [23:0] gen_out
);

wire signed [15:0] wave_raw;

top_wave u_top_wave (
  .clk        (clk),
  .rst        (rst),
  .dc         (dc_sel),
  .sel        (sel_f),
  .sel_wave   (sel_wave),
  .wave_final (wave_raw)
);

amp u_amp(
  .wave (wave_raw),
  .amp_sel (amp_sel),
  .wave_out (gen_out)
);

endmodule 