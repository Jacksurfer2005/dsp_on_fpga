library verilog;
use verilog.vl_types.all;
entity noise_freq is
    port(
        clk_i           : in     vl_logic;
        rst_i           : in     vl_logic;
        sel_i           : in     vl_logic_vector(1 downto 0);
        en_f            : out    vl_logic
    );
end noise_freq;
