library verilog;
use verilog.vl_types.all;
entity count_addr_RAM is
    port(
        clk             : in     vl_logic;
        reset_n         : in     vl_logic;
        addr            : out    vl_logic_vector(15 downto 0)
    );
end count_addr_RAM;
