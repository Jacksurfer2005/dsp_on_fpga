module my_DFF_40 #(
    parameter WIDTH_reg = 40
)
(
    input  wire                        clk, 
    input  wire                        rst_n,
    input  wire signed [WIDTH_reg-1:0]  d_in,
    output reg  signed [WIDTH_reg-1:0] q_out
);
    always @(posedge clk) begin 
        if (!rst_n) begin 
            q_out <= 0;
        end
        else begin 
            q_out <= d_in; 
        end
    end

endmodule