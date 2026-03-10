`timescale 1ns / 1ps

module tb_freq_divider();

    // 1. Khai báo các tín hiệu kết nối với module DUT (Device Under Test)
    reg clk_in;
    reg rst;
    reg [1:0] sel;
    wire clk_en;

    // 2. Gọi module cần kiểm tra (Instantate DUT)
    freq_divider dut (
        .clk_in(clk_in),
        .rst(rst),
        .sel(sel),
        .clk_en(clk_en)
    );

    // 3. Tạo xung Clock hệ thống 50MHz (Chu kỳ T = 20ns)
    initial begin
        clk_in = 0;
        forever #10 clk_in = ~clk_in; // Đảo trạng thái sau mỗi 10ns
    end

    // 4. Kịch bản mô phỏng
    initial begin
        // Khởi tạo giá trị ban đầu
        rst = 1;
        sel = 2'b00;

        // Thả reset sau 100ns (Reset tích cực cao)
        #10000 rst = 0;

        // Kiểm tra sel = 2'b11 (100 KHz - Hệ số chia là 2)
        // clk_en sẽ bật lên sau mỗi 2 chu kỳ clk_in
        $display("Testing sel = 11 (Divisor = 2)");
        sel = 2'b11;
        #20000;

        // Kiểm tra sel = 2'b10 (50 KHz - Hệ số chia là 4)
        $display("Testing sel = 10 (Divisor = 4)");
        sel = 2'b10;
        #20000;

        // Kiểm tra sel = 2'b01 (5 KHz - Hệ số chia là 39)
        $display("Testing sel = 01 (Divisor = 39)");
        sel = 2'b01;
        #20000;

        // Kiểm tra sel = 2'b00 (1 KHz - Hệ số chia là 195)
        $display("Testing sel = 00 (Divisor = 195)");
        sel = 2'b00;
        #20000;

        // Kết thúc mô phỏng
        $display("Simulation Finished!");
        $stop;
    end

    // 5. (Tùy chọn) Theo dõi tín hiệu trên Console
    initial begin
        $monitor("Time=%0t | rst=%b | sel=%b | divisor=%d | clk_en=%b", 
                 $time, rst, sel, dut.current_divisor, clk_en);
    end

endmodule