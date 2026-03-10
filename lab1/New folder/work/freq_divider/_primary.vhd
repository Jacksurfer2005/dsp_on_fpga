library verilog;
use verilog.vl_types.all;
entity freq_divider is
    port(
        clk_in          : in     vl_logic;
        rst             : in     vl_logic;
        sel             : in     vl_logic_vector(1 downto 0);
        clk_en          : out    vl_logic
    );
end freq_divider;
