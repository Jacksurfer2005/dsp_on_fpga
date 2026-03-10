`timescale 1ns / 1ps

module freq_divider_tb();

    reg clk_in;
    reg rst;
    reg [1:0] sel;
    wire clk_out;

    // Khởi tạo Module (UUT)
    freq_divider uut (
        .clk_in(clk_in),
        .rst(rst),
        .sel(sel),
        .clk_out(clk_out)
    );

    // Tạo xung clock giả lập 50MHz (Chu kỳ 20ns)
    initial begin
        clk_in = 0;
        forever #10 clk_in = ~clk_in;
    end

    // Kịch bản Testbench
    initial begin
        // Trạng thái ban đầu và Reset
        rst = 1; sel = 2'b00;
        #100 rst = 0; // Gỡ reset sau 100ns
        // 1. Chạy với tần số 1 KHz
        $display("Dang chay tan so 1 KHz...");
        sel = 2'b00;
        #2000000;  
        // 2. Chạy với tần số 2 KHz
        $display("Dang chay tan so 2 KHz...");
        sel = 2'b01;
        #1000000; 
        // 3. Chạy với tần số 5 KHz
        $display("Dang chay tan so 5 KHz...");
        sel = 2'b10;
        #500000; 
        // 4. Chạy với tần số 10 KHz
        $display("Dang chay tan so 10 KHz...");
        sel = 2'b11;
        #500000; 
        
        $stop; // Kết thúc mô phỏng
    end

endmodule