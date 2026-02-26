library verilog;
use verilog.vl_types.all;
entity ecg_lut is
    port(
        clk             : in     vl_logic;
        address         : in     vl_logic_vector(7 downto 0);
        data            : out    vl_logic_vector(15 downto 0)
    );
end ecg_lut;
