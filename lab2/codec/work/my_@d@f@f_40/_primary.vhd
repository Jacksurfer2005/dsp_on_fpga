library verilog;
use verilog.vl_types.all;
entity my_DFF_40 is
    generic(
        WIDTH_reg       : integer := 40
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        d_in            : in     vl_logic_vector;
        q_out           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH_reg : constant is 1;
end my_DFF_40;
