library verilog;
use verilog.vl_types.all;
entity saw_wave is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        saw_out         : out    vl_logic_vector(15 downto 0)
    );
end saw_wave;
