library verilog;
use verilog.vl_types.all;
entity square_wave is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        dc              : in     vl_logic_vector(1 downto 0);
        clk_en          : in     vl_logic;
        level           : out    vl_logic;
        square_out      : out    vl_logic_vector(15 downto 0)
    );
end square_wave;
