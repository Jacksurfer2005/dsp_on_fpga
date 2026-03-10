library verilog;
use verilog.vl_types.all;
entity trig_wave is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        max_value       : in     vl_logic_vector(7 downto 0);
        min_value       : in     vl_logic_vector(7 downto 0);
        trig_out        : out    vl_logic_vector(15 downto 0)
    );
end trig_wave;
