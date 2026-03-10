library verilog;
use verilog.vl_types.all;
entity multi is
    generic(
        a_width         : integer := 24;
        b_width         : integer := 16;
        out_width       : integer := 40
    );
    port(
        a               : in     vl_logic_vector;
        b               : in     vl_logic_vector;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of a_width : constant is 1;
    attribute mti_svvh_generic_type of b_width : constant is 1;
    attribute mti_svvh_generic_type of out_width : constant is 1;
end multi;
