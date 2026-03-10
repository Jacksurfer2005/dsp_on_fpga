module i2c_protocol (
   input  wire         clk      ,
   input  wire         reset_n  ,
   input  wire         start    , 
   input  wire [6:0]   addr     ,
   input  wire         wr_rd    ,
   input  wire [7:0]   data_st  ,
   input  wire [7:0]   data_nd  ,
   
   output reg          busy     ,
   output reg          done     ,

   inout  wire        sclk     ,
   inout  wire        sdin 
);
   reg  [ 6:0]   addr_send;
   reg  [ 7:0]   data_st_send, data_nd_send;
   reg           wr_rd_send;
   reg           sclk_tmp, sdin_tmp;
   reg  [ 4:0]   count_q, count_d;
   wire [26:0]   data;

   assign data = {addr_send, wr_rd_send, 1'b1, data_st_send, 1'b1, data_nd_send, 1'b1};

   // Dinh nghia cac trang thai (thay cho enum)
   localparam IDLE        = 5'd0, 
              START       = 5'd1,
              START_CONT  = 5'd2,
              BUF_1       = 5'd3,
              DATA_SEND_1 = 5'd4,
              DATA_SEND_2 = 5'd5,
              DATA_SEND_3 = 5'd6,
              DATA_SEND_4 = 5'd7,
              BUF_2       = 5'd8,
              STOP        = 5'd9,
              DONE        = 5'd10;

   reg [4:0] state_d, state_q; 

   // Lay du lieu dau vao khi co tin hieu start
   always @(posedge start) begin 
      addr_send      <= addr;
      data_st_send   <= data_st;
      data_nd_send   <= data_nd;
      wr_rd_send     <= wr_rd;
   end

   // Chuyen doi trang thai
   always @(posedge clk or negedge reset_n) begin 
      if (!reset_n) begin 
         state_q <= IDLE;
         count_q <= 5'd27;
      end else begin 
         state_q <= state_d;
         count_q <= count_d;
      end
   end

   // Khoi logic to hop dieu khien trang thai
   always @(*) begin 
      case (state_q) 
         IDLE: begin 
            if (start) state_d = START;
            else       state_d = IDLE;
            sclk_tmp = 1; 
            sdin_tmp = 1;
            count_d  = 5'd26;
            done     = 0;
            busy     = 0;
         end
         START: begin 
            state_d  = START_CONT;
            count_d  = count_q;
            sclk_tmp = 1;
            sdin_tmp = 0;
            done     = 0;
            busy     = 1;
         end
         START_CONT: begin 
            state_d  = BUF_1;
            count_d  = count_q;
            sclk_tmp = 0;
            sdin_tmp = 0;
            busy     = 1;
            done     = 0;
         end
         BUF_1: begin 
            state_d  = DATA_SEND_1;
            count_d  = count_q;
            sclk_tmp = 0;
            sdin_tmp = 0;
            busy     = 1;
            done     = 0;
         end
         DATA_SEND_1: begin 
            state_d  = DATA_SEND_2;
            count_d  = count_q;
            sclk_tmp = 0;
            sdin_tmp = data[count_q];
            busy     = 1;
            done     = 0;
         end
         DATA_SEND_2: begin 
            state_d  = DATA_SEND_3;
            count_d  = count_q;
            sclk_tmp = 1;
            sdin_tmp = data[count_q];
            busy     = 1;
            done     = 0;
         end
         DATA_SEND_3: begin 
            state_d  = DATA_SEND_4;
            count_d  = count_q;
            sclk_tmp = 1;
            sdin_tmp = data[count_q];
            busy     = 1;
            done     = 0;
         end
         DATA_SEND_4: begin 
            count_d = count_q - 5'd1;
            if (count_q == 0) state_d = BUF_2;
            else              state_d = DATA_SEND_1;
            sclk_tmp = 0;
            sdin_tmp = data[count_q];
            busy     = 1;
            done     = 0;
         end
         BUF_2: begin 
            state_d  = STOP;
            count_d  = 5'd26;
            sclk_tmp = 0;
            sdin_tmp = 0;
            busy     = 1;
            done     = 0;
         end
         STOP: begin 
            state_d  = DONE;
            count_d  = 5'd26;
            sclk_tmp = 1;
            sdin_tmp = 0;
            busy     = 1;
            done     = 0;
         end
         DONE: begin 
            state_d  = IDLE;
            count_d  = 5'd26;
            sclk_tmp = 1;
            sdin_tmp = 1;
            busy     = 1;
            done     = 1;
         end
         default: begin
            state_d  = IDLE;
            count_d  = 5'd26;
            sclk_tmp = 0;
            sdin_tmp = 0;
            busy     = 0;
            done     = 0;
         end
      endcase
   end

   assign sclk = (sclk_tmp) ? 1'b1 : 1'b0;
   assign sdin = (sdin_tmp) ? 1'bz : 1'b0;

endmodule