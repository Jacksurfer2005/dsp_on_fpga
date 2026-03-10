library verilog;
use verilog.vl_types.all;
entity paralell_serial is
    port(
        clk_12M         : in     vl_logic;
        start           : in     vl_logic;
        data_paralell   : in     vl_logic_vector(23 downto 0);
        data_serial     : out    vl_logic;
        bclk_out        : out    vl_logic;
        lrclk           : out    vl_logic;
        clk_fsample     : out    vl_logic
    );
end paralell_serial;
