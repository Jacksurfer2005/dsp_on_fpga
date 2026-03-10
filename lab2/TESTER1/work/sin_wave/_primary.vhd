library verilog;
use verilog.vl_types.all;
entity sin_wave is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        clk_en          : in     vl_logic;
        sin_out         : out    vl_logic_vector(15 downto 0)
    );
end sin_wave;
