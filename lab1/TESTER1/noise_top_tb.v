`timescale 1ns / 1ps

module noise_top_tb;

reg clk_top_tb;
reg rst_top_tb;
reg [1:0] sel_n_tb;
reg [2:0] sel_amp_tb;
wire signed [23:0] top_o_tb;

noise_top dut (
    .clk_t(clk_top_tb),
    .rst_t(rst_top_tb),
    .sel_n(sel_n_tb),
    .sel_amp(sel_amp_tb),
    .top_o(top_o_tb)
);


always #10 clk_top_tb = ~clk_top_tb;

initial begin
    clk_top_tb = 0;
    rst_top_tb = 1;
    sel_n_tb   = 2'b00;
    #200;
	 
    rst_top_tb = 0;   
    sel_n_tb   = 2'b00;
    
    #2000000;
	 
	 sel_n_tb   = 2'b01;
	 sel_amp_tb = 2'b01;
    #2000000;
	 
	 sel_n_tb   = 2'b01;
	 sel_amp_tb = 2'b10;
	 #2000000;
	 
	 sel_n_tb   = 2'b01;
	 sel_amp_tb = 2'b11;
	 #2000000;
	 
	 sel_n_tb   = 2'b11;
	 #2000000;
    
end

endmodule