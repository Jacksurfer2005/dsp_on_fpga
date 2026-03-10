library verilog;
use verilog.vl_types.all;
entity wave_gen is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        sel_f           : in     vl_logic_vector(1 downto 0);
        dc_sel          : in     vl_logic_vector(1 downto 0);
        amp_sel         : in     vl_logic_vector(2 downto 0);
        sel_wave        : in     vl_logic_vector(2 downto 0);
        gen_out         : out    vl_logic_vector(23 downto 0)
    );
end wave_gen;
