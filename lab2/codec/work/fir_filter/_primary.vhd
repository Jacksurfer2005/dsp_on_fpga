library verilog;
use verilog.vl_types.all;
entity fir_filter is
    port(
        clk             : in     vl_logic;
        reset_n         : in     vl_logic;
        is_key_config   : in     vl_logic_vector(3 downto 0);
        sw              : in     vl_logic_vector(9 downto 0);
        bclk            : out    vl_logic;
        serial_data     : out    vl_logic;
        xck             : out    vl_logic;
        daclrck         : out    vl_logic;
        sclk            : out    vl_logic;
        sdin            : out    vl_logic;
        led_red         : out    vl_logic_vector(9 downto 0)
    );
end fir_filter;
