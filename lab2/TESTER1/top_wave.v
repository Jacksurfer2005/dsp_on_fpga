module top_wave (
 input clk,
 input rst,
 input [1:0] dc,
 input [1:0] sel,
 input [2:0] sel_wave,
 output  signed [15:0] wave_final
);
 
  wire [1:0] sel_i = sel;
  wire clk_en_tb;
  wire signed [15:0] i0;
  wire signed [15:0] i1;
  wire signed [15:0] i2;
  wire signed [15:0] i3;
  wire signed [15:0] i4;
  wire level;
 
 freq_divider u_freq_divider (
   .clk_in (clk),
	.rst    (rst),
	.sel    (sel),
	.clk_en (clk_en_tb)
);

 square_wave u_square_wave (
   .clk  (clk),
	.rst  (rst),
	.dc   (dc),
	.clk_en (clk_en_tb),
	.level (level),
	.square_out (i0)
);

 saw_wave u_saw_wave (
   .clk (clk),
	.rst (rst),
   .clk_en (clk_en_tb),
	.dc  (level),
	.dc_sel (sel_i),
	.saw_out (i1)
);
 
 trig_wave u_trig_wave (
   .clk    (clk),
	.rst    (rst),
	.clk_en (clk_en_tb),
	.dc     (level),
	.dc_sel (sel_i),
	.trig_out (i2)
);

 sin_wave u_sin_wave (
   .clk (clk),
   .rst (rst),
   .clk_en (clk_en_tb),
   .sin_out (i3)
);

 ecg_wave u_ecg_wave (
   .clk     (clk),
   .rst     (rst),
   .clk_en  (clk_en_tb),
   .ecg_out (i4)
);

 mux5to1 u_mux (sel_wave,i0,i1,i2,i3,i4,wave_final);
 
endmodule