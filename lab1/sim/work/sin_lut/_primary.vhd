library verilog;
use verilog.vl_types.all;
entity sin_lut is
    port(
        clk             : in     vl_logic;
        address         : in     vl_logic_vector(7 downto 0);
        data            : out    vl_logic_vector(15 downto 0)
    );
end sin_lut;
