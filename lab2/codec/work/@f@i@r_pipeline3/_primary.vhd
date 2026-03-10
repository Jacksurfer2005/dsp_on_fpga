library verilog;
use verilog.vl_types.all;
entity FIR_pipeline3 is
    generic(
        WIDTH_data      : integer := 24;
        WIDTH_coeff     : integer := 16;
        TAP             : integer := 111;
        WIDTH_reg       : integer := 40
    );
    port(
        clk             : in     vl_logic;
        reset_n         : in     vl_logic;
        data_in         : in     vl_logic_vector;
        data_out        : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH_data : constant is 1;
    attribute mti_svvh_generic_type of WIDTH_coeff : constant is 1;
    attribute mti_svvh_generic_type of TAP : constant is 1;
    attribute mti_svvh_generic_type of WIDTH_reg : constant is 1;
end FIR_pipeline3;
