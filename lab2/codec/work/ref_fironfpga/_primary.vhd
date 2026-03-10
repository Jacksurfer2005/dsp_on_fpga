library verilog;
use verilog.vl_types.all;
entity ref_fironfpga is
    port(
        CLOCK_50        : in     vl_logic;
        KEY             : in     vl_logic_vector(3 downto 0);
        SW              : in     vl_logic_vector(9 downto 0);
        LEDR            : out    vl_logic_vector(9 downto 0);
        AUD_ADCDAT      : in     vl_logic;
        AUD_ADCLRCK     : inout  vl_logic;
        AUD_BCLK        : inout  vl_logic;
        AUD_DACDAT      : out    vl_logic;
        AUD_DACLRCK     : inout  vl_logic;
        AUD_XCK         : out    vl_logic;
        FPGA_I2C_SCLK   : out    vl_logic;
        FPGA_I2C_SDAT   : inout  vl_logic
    );
end ref_fironfpga;
