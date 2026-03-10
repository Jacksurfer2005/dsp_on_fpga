library verilog;
use verilog.vl_types.all;
entity mux5to1 is
    port(
        sel             : in     vl_logic_vector(2 downto 0);
        i0              : in     vl_logic_vector(15 downto 0);
        i1              : in     vl_logic_vector(15 downto 0);
        i2              : in     vl_logic_vector(15 downto 0);
        i3              : in     vl_logic_vector(15 downto 0);
        i4              : in     vl_logic_vector(15 downto 0);
        \out\           : out    vl_logic_vector(15 downto 0)
    );
end mux5to1;
