library verilog;
use verilog.vl_types.all;
entity saw_wave is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        clk_en          : in     vl_logic;
        dc              : in     vl_logic;
        dc_sel          : in     vl_logic_vector(1 downto 0);
        saw_out         : out    vl_logic_vector(15 downto 0)
    );
end saw_wave;
