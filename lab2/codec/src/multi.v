module multi #(
    parameter    a_width = 24 ,
                 b_width = 16 ,
                 out_width = 40 // a_width + b_width 
) 
(
    input  wire signed [a_width-1:0] a,
    input  wire signed [b_width-1:0] b,
    output wire signed [out_width-1:0] out
);
    assign out = a * b; 

endmodule