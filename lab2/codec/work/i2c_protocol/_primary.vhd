library verilog;
use verilog.vl_types.all;
entity i2c_protocol is
    port(
        clk             : in     vl_logic;
        reset_n         : in     vl_logic;
        start           : in     vl_logic;
        addr            : in     vl_logic_vector(6 downto 0);
        wr_rd           : in     vl_logic;
        data_st         : in     vl_logic_vector(7 downto 0);
        data_nd         : in     vl_logic_vector(7 downto 0);
        busy            : out    vl_logic;
        done            : out    vl_logic;
        sclk            : inout  vl_logic;
        sdin            : inout  vl_logic
    );
end i2c_protocol;
