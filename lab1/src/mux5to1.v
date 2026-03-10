module mux5to1 (
    input clk, rst,
    input [2:0] sel,
    output reg signed [15:0] out
);

    wire [15:0] i0;
    wire [15:0] i1; 
    wire [15:0] i2; 
    wire signed [15:0] i3; 
    wire signed [15:0] i4; 
    
    saw_wave wave0 (
        .clk(clk),
        .rst(rst),
        .saw_out(i0)
    );
    square_wave wave1 (
        .clk(clk),
        .rst(rst),
        .square_out(i1)
    );
    trig_wave wave2 (
        .clk(clk),
        .rst(rst),
        .trig_out(i2)
    );
    ecg_wave wave3 (
        .clk(clk),
        .rst(rst),
        .ecg_out(i3)
    );
    sin_wave wave4 (
        .clk(clk),
        .rst(rst),
        .sin_out(i4)
    );
    
    always @(*) begin
        case (sel)
            3'b000:  out = i0;
            3'b001:  out = i1;
            3'b010:  out = i2;
            3'b011:  out = i3;
            3'b100:  out = i4;
            default: out = 16'd0;
        endcase
    end

endmodule