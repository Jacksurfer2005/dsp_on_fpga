library verilog;
use verilog.vl_types.all;
entity top_wave is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        dc              : in     vl_logic_vector(1 downto 0);
        sel             : in     vl_logic_vector(1 downto 0);
        sel_wave        : in     vl_logic_vector(2 downto 0);
        wave_final      : out    vl_logic_vector(15 downto 0)
    );
end top_wave;
