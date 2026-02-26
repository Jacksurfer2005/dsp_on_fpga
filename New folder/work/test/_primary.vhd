library verilog;
use verilog.vl_types.all;
entity test is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        dc              : in     vl_logic_vector(1 downto 0);
        dc_in           : in     vl_logic;
        sel             : in     vl_logic_vector(1 downto 0);
        level           : out    vl_logic;
        square_out      : out    vl_logic_vector(15 downto 0);
        saw_out         : out    vl_logic_vector(15 downto 0);
        trig_out        : out    vl_logic_vector(15 downto 0);
        sin_out         : out    vl_logic_vector(15 downto 0);
        ecg_out         : out    vl_logic_vector(15 downto 0)
    );
end test;
