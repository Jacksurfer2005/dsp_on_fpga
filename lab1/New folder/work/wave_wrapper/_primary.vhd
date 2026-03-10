library verilog;
use verilog.vl_types.all;
entity wave_wrapper is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        enable          : in     vl_logic;
        wave_in         : in     vl_logic_vector(23 downto 0);
        noise_in        : in     vl_logic_vector(23 downto 0);
        wave_in_wrapper : in     vl_logic_vector(2 downto 0);
        amp_wrapper     : in     vl_logic_vector(2 downto 0);
        dc_wrapper      : in     vl_logic_vector(1 downto 0);
        sel_f_wrapper   : in     vl_logic_vector(1 downto 0);
        noise_sel       : in     vl_logic_vector(1 downto 0);
        noise_amp       : in     vl_logic_vector(2 downto 0);
        wave_wrapper    : out    vl_logic_vector(23 downto 0)
    );
end wave_wrapper;
