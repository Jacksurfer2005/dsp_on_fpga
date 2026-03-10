module amp(
 input signed [15:0] wave,
 input [2:0] amp_sel,
 output signed [23:0] wave_out
);

wire signed [23:0] wave_ext;

assign wave_ext = {{8{wave[15]}},wave};

assign wave_out =
                  (amp_sel ==3'b000) ? wave_ext:
                  (amp_sel ==3'b001) ? (wave_ext >>>1):
						(amp_sel ==3'b010) ? (wave_ext >>>2):
						(amp_sel ==3'b011) ? (wave_ext <<<1):
						(amp_sel ==3'b100) ? (wave_ext <<<2):
						        wave_ext;
								  
endmodule 