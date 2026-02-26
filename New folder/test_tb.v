`timescale 1ns / 1ps

module test_tb();
    reg clk;
    reg rst;
    reg dc_in_tb;
    reg [1:0] dc_sel_tb;
    reg [1:0] sel_tb;

    wire level_tb;
    wire signed [15:0] sq_out, saw_out, trig_out, sin_out, ecg_out;

    test dut (
        .clk        (clk),
        .rst        (rst),
        .dc         (dc_sel_tb),
        .dc_in      (dc_in_tb),
        .sel        (sel_tb),
        .level      (level_tb),
        .square_out (sq_out),
        .saw_out    (saw_out),
        .trig_out   (trig_out),
        .sin_out    (sin_out),
        .ecg_out    (ecg_out)
    );

    // Tạo xung Clock 50MHz (Chu kỳ 20ns) [cite: 40]
    initial clk = 0;
    always #10 clk = ~clk;

    initial begin
        // --- GIAI ĐOẠN 1: KHỞI TẠO ---
        rst = 1;
        dc_in_tb = 1;     // Cho phép sóng chạy
        dc_sel_tb = 2'b10; // Thiết lập step/duty cycle trung bình [cite: 3, 10, 50]
        sel_tb = 2'b00;    // Tần số 1 KHz [cite: 18]
        
        #100 rst = 0;      // Thả reset [cite: 42]
        
        // --- GIAI ĐOẠN 2: CHẠY Ở TẦN SỐ THẤP (1 KHz) ---
        // Chạy lâu một chút để thấy đủ chu kỳ các sóng Sin/ECG
        #5000000; 

        // --- GIAI ĐOẠN 3: ĐỔI HƯỚNG SÓNG TRIG ---
        // Thử gạt dc_in về 0 để thấy sóng Trig và Saw đi xuống/dừng
        dc_in_tb = 0; 
        #2000000;
        dc_in_tb = 1;

        // --- GIAI ĐOẠN 4: CHẠY Ở TẦN SỐ CAO (50 KHz) ---
        // Đổi sel sang 2'b10 để thấy sóng dày đặc hơn [cite: 20]
        sel_tb = 2'b10;
        #1000000;

        $stop; // Dừng mô phỏng
    end

endmodule