library verilog;
use verilog.vl_types.all;
entity DE10_Standard_Top is
    port(
        CLOCK_50        : in     vl_logic;
        KEY             : in     vl_logic_vector(3 downto 0);
        SW              : in     vl_logic_vector(9 downto 0);
        LEDR            : out    vl_logic_vector(9 downto 0);
        GPIO            : inout  vl_logic_vector(35 downto 0)
    );
end DE10_Standard_Top;
