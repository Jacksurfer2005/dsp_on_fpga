library verilog;
use verilog.vl_types.all;
entity audio_codec is
    port(
        clk_i2c         : in     vl_logic;
        reset_n         : in     vl_logic;
        is_config       : in     vl_logic;
        sclk            : out    vl_logic;
        sdin            : out    vl_logic;
        done            : out    vl_logic
    );
end audio_codec;
