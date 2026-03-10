library verilog;
use verilog.vl_types.all;
entity gain is
    port(
        data_in         : in     vl_logic_vector(23 downto 0);
        gain_coeff      : in     vl_logic_vector(23 downto 0);
        data_out        : out    vl_logic_vector(23 downto 0)
    );
end gain;
