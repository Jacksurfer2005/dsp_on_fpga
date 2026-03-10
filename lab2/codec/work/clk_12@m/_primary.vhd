library verilog;
use verilog.vl_types.all;
entity clk_12M is
    port(
        reset_n         : in     vl_logic;
        clk_in          : in     vl_logic;
        clk_out         : out    vl_logic
    );
end clk_12M;
