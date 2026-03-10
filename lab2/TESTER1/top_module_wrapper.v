module DE10_Standard_Top (
    input  wire CLOCK_50,
    
    input  wire [3:0]  KEY,  
    input  wire [9:0]  SW,   

    output wire [9:0]  LEDR, 
    inout  wire [35:0] GPIO  
);
    wire signed [23:0] w_wave_out;
    wire signed [23:0] w_dummy_wave;
    wire signed [23:0] w_dummy_noise;

    wave_wrapper u_dut (
        .clk              (CLOCK_50),
        .rst              (~KEY[0]),
        .enable           (SW[0]),
        
        .wave_in          (w_dummy_wave),   
        .noise_in         (w_dummy_noise),  
        
        .wave_in_wrapper  (SW[3:1]),        
        .amp_wrapper      (SW[6:4]),        
        .dc_wrapper       (SW[8:7]), 
        .sel_f_wrapper    ({SW[9], ~KEY[1]}), 

        .noise_sel        (2'b11),          // Cai dat co dinh muc tan so nhieu cao nhat
        .noise_amp        (3'b010),         // Cai dat co dinh bien do nhieu trung binh
        
        .wave_wrapper     (w_wave_out)      // Tin hieu 24-bit ngo ra tu module
    );

    // Gan 10 bit cao nhat (MSB) ra LED de quan sat truc quan bien do song
    assign LEDR = w_wave_out[23:14];
    // Dua toan bo tin hieu 24-bit ra header GPIO de do bang Oscilloscope
    assign GPIO[23:0] = w_wave_out;
    // Cho cac chan GPIO con lai o trang thai tro khang cao de an toan
    assign GPIO[35:24] = 12'bz;

endmodule