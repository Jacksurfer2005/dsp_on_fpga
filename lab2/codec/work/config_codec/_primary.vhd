library verilog;
use verilog.vl_types.all;
entity config_codec is
    port(
        clk             : in     vl_logic;
        reset_n         : in     vl_logic;
        busy            : in     vl_logic;
        is_config       : in     vl_logic;
        done_config     : out    vl_logic;
        ack_i2c         : out    vl_logic;
        wr_rd           : out    vl_logic;
        addr            : out    vl_logic_vector(6 downto 0);
        addr_reg        : out    vl_logic_vector(7 downto 0);
        data_config     : out    vl_logic_vector(7 downto 0)
    );
end config_codec;
