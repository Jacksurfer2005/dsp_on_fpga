`timescale 1ns / 1ps

module mux5to1_tb();

    reg clk;
    reg rst;
    reg [2:0] sel;
    wire signed [15:0] out;

    mux5to1 uut (
        .clk(clk),
        .rst(rst),
        .sel(sel),
        .out(out)
    );

    initial
    begin
        clk = 0;
        rst = 1;
    end
     
    always #5 clk = ~clk;

    initial begin
        rst = 1; sel = 3'b000;
        #100 rst = 0; // Reset
        
        // --- SỬA ĐỔI Ở ĐÂY: Tăng thời gian delay ---
        
        // 1. Sawtooth (Răng cưa)
        $display("Dang chay Sawtooth...");
        sel = 3'b000;
        #200000;  // Tăng lên 200,000 ns
        
        // 2. Square (Vuông)
        $display("Dang chay Square...");
        sel = 3'b001;
        #200000; 

        // 3. Triangle (Tam giác)
        $display("Dang chay Triangle...");
        sel = 3'b010;
        #200000; 

        // 4. ECG
        $display("Dang chay ECG...");
        sel = 3'b011;
        #200000; 

        // 5. Sine (Sin)
        $display("Dang chay Sine...");
        sel = 3'b100;
        #200000; 
        
        $stop;
    end
endmodule