library verilog;
use verilog.vl_types.all;
entity ecg_wave is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        clk_en          : in     vl_logic;
        ecg_out         : out    vl_logic_vector(15 downto 0)
    );
end ecg_wave;
