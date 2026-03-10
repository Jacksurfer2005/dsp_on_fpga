library verilog;
use verilog.vl_types.all;
entity square_wave is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        square_out      : out    vl_logic_vector(7 downto 0)
    );
end square_wave;
