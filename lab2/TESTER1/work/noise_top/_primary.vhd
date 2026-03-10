library verilog;
use verilog.vl_types.all;
entity noise_top is
    port(
        clk_t           : in     vl_logic;
        rst_t           : in     vl_logic;
        sel_n           : in     vl_logic_vector(1 downto 0);
        sel_amp         : in     vl_logic_vector(2 downto 0);
        top_o           : out    vl_logic_vector(23 downto 0)
    );
end noise_top;
