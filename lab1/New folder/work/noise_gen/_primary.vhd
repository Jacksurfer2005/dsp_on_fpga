library verilog;
use verilog.vl_types.all;
entity noise_gen is
    port(
        clk_g           : in     vl_logic;
        rst_i           : in     vl_logic;
        en_g            : in     vl_logic;
        gen_o           : out    vl_logic_vector(15 downto 0)
    );
end noise_gen;
