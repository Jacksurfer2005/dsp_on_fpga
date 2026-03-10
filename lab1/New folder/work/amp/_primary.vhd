library verilog;
use verilog.vl_types.all;
entity amp is
    port(
        wave            : in     vl_logic_vector(15 downto 0);
        amp_sel         : in     vl_logic_vector(2 downto 0);
        wave_out        : out    vl_logic_vector(23 downto 0)
    );
end amp;
