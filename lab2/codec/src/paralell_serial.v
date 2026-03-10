module paralell_serial (
   input  wire         clk_12M,
   input  wire         start,
   input  wire [23:0]  data_paralell,

   output wire         data_serial,
   output wire         bclk_out,
   output wire         lrclk,
   output wire         clk_fsample
);
   // Cac trang thai FSM
   localparam IDLE         = 4'd0,
              LEFT_READY   = 4'd1,
              LEFT_SEND_1  = 4'd2,
              LEFT_SEND_2  = 4'd3,
              STOP_LEFT    = 4'd4,
              RIGHT_READY  = 4'd5,
              RIGHT_SEND_3 = 4'd6,
              RIGHT_SEND_4 = 4'd7,
              STOP_RIGHT   = 4'd8;

   reg [3:0] state_q, state_d;
   reg [23:0] data_paralell_pre;
   reg [ 8:0] count_d, count_q;
   reg [ 4:0] count_bit_d, count_bit_q;
   reg        lrck_tmp;
   reg        bclk_reg;

   assign bclk_out = bclk_reg;

   always @(posedge clk_fsample) begin 
      data_paralell_pre <= data_paralell;
   end

   always @(posedge clk_12M) begin 
      state_q     <= state_d;
      count_q     <= count_d;
      count_bit_q <= count_bit_d;
   end

   always @(*) begin 
      case (state_q)
         IDLE: begin 
            if (start) state_d = LEFT_READY;
            else       state_d = IDLE;
            bclk_reg    = 1;
            count_bit_d = 5'd23;
            count_d     = 9'd0;
            lrck_tmp    = 0;
         end
         LEFT_READY: begin 
            state_d     = LEFT_SEND_1;
            bclk_reg    = 1;
            count_bit_d = 5'd23;
            count_d     = count_q + 9'd1;
            lrck_tmp    = 1;
         end
         LEFT_SEND_1: begin 
            state_d     = LEFT_SEND_2;
            bclk_reg    = 0;
            count_bit_d = count_bit_q;
            count_d     = count_q + 9'd1;
            lrck_tmp    = 1;
         end
         LEFT_SEND_2: begin 
            if (count_bit_q == 0) begin 
               state_d     = STOP_LEFT;
               count_bit_d = 5'd23;
            end else begin 
               state_d     = LEFT_SEND_1;
               count_bit_d = count_bit_q - 5'd1;
            end
            count_d  = count_q + 9'd1;
            bclk_reg = 1;
            lrck_tmp = 1;
         end
         STOP_LEFT: begin 
            if (count_q == 9'd130) begin
               state_d     = RIGHT_READY;
               count_bit_d = 5'd23;
            end else begin 
               state_d     = state_q;
               count_bit_d = 5'd23;
            end
            count_d  = count_q + 9'd1;
            bclk_reg = 0;
            lrck_tmp = 1;
         end
         RIGHT_READY: begin
            state_d     = RIGHT_SEND_3;
            count_bit_d = 5'd23;
            bclk_reg    = 1;
            count_d     = count_q + 9'd1;
            lrck_tmp    = 0;
         end
         RIGHT_SEND_3: begin 
            state_d     = RIGHT_SEND_4;
            bclk_reg    = 0;
            count_bit_d = count_bit_q;
            count_d     = count_q + 9'd1;
            lrck_tmp    = 0;
         end
         RIGHT_SEND_4: begin 
            if (count_bit_q == 0) begin 
               state_d     = STOP_RIGHT;
               count_bit_d = 5'd23;
            end else begin 
               state_d     = RIGHT_SEND_3;
               count_bit_d = count_bit_q - 5'd1;
            end
            count_d  = count_q + 9'd1;
            bclk_reg = 1;
            lrck_tmp = 0;
         end
         STOP_RIGHT: begin 
            if (count_q == 9'd260) begin 
               state_d = LEFT_READY;
               count_d = 9'd0;
            end else begin 
               state_d = state_q;
               count_d = count_q + 9'd1;
            end
            count_bit_d = 5'd23;
            bclk_reg    = 0;
            lrck_tmp    = 0;
         end
         default: begin 
            state_d     = IDLE;
            bclk_reg    = 0;
            count_bit_d = 0;
            count_d     = 0;
            lrck_tmp    = 0;
         end
      endcase 
   end

   assign data_serial = data_paralell_pre[count_bit_q];
   assign lrclk       = lrck_tmp;
   assign clk_fsample = lrck_tmp;

endmodule