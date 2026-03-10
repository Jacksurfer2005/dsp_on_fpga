module config_codec (
   input clk,
   input reset_n,
   input busy,
   input is_config,

   output done_config,
   output ack_i2c,
   output wr_rd,
   output [6:0] addr,
   output [7:0] addr_reg,
   output [7:0] data_config
);

reg [15:0] data_array [0:9];

initial begin
   data_array[0] = 16'h1e00;
   data_array[1] = 16'h0c00;
   data_array[2] = 16'h0579;
   data_array[3] = 16'h0779;
   data_array[4] = 16'h0e09;
   data_array[5] = 16'h1001;
   data_array[6] = 16'h13ff;
   data_array[7] = 16'h0812;
   data_array[8] = 16'h0a00;
   data_array[9] = 16'h0a00;
end

reg [3:0] state_q, state_d;
reg [3:0] count_q, count_d;

reg temp_ack_i2c;
reg done;

wire [15:0] data_temp;

assign data_temp   = data_array[count_q];
assign addr_reg    = data_temp[15:8];
assign data_config = data_temp[7:0];

localparam IDLE      = 4'd0;
localparam IS_CONFIG = 4'd1;
localparam SEND_1    = 4'd2;
localparam SEND_2    = 4'd3;
localparam IS_READY  = 4'd4;
localparam SEND_LAST = 4'd5;
localparam DONE      = 4'd6;

always @(posedge clk or negedge reset_n) begin
   if (!reset_n) begin
      state_q <= IDLE;
      count_q <= 0;
   end
   else begin
      state_q <= state_d;
      count_q <= count_d;
   end
end

always @(*) begin
   case(state_q)

   IDLE:
   begin
      if (~busy) state_d = IS_CONFIG;
      else state_d = state_q;

      count_d = 0;
      temp_ack_i2c = 0;
      done = 0;
   end

   IS_CONFIG:
   begin
      if ((~is_config) && (~busy))
         state_d = SEND_1;
      else
         state_d = state_q;

      count_d = count_q;
      temp_ack_i2c = 0;
      done = 0;
   end

   SEND_1:
   begin
      state_d = SEND_2;
      count_d = count_q;
      temp_ack_i2c = 1;
      done = 0;
   end

   SEND_2:
   begin
      state_d = IS_READY;
      count_d = count_q;
      temp_ack_i2c = 1;
      done = 0;
   end

   IS_READY:
   begin
      if (~busy)
         state_d = SEND_LAST;
      else
         state_d = state_q;

      count_d = count_q;
      temp_ack_i2c = 0;
      done = 0;
   end

   SEND_LAST:
   begin
      if (count_q == 9)
         state_d = DONE;
      else
         state_d = IS_CONFIG;

      count_d = count_q + 1;
      temp_ack_i2c = 0;
      done = 0;
   end

   DONE:
   begin
      state_d = state_q;
      count_d = 0;
      temp_ack_i2c = 0;
      done = 1;
   end

   default:
   begin
      state_d = IDLE;
      count_d = 0;
      temp_ack_i2c = 0;
      done = 0;
   end

   endcase
end

assign addr        = 7'b0011010;
assign wr_rd       = 1'b0;
assign done_config = done;
assign ack_i2c     = temp_ack_i2c;

endmodule