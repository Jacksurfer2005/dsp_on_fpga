library verilog;
use verilog.vl_types.all;
entity single_port_RAM is
    generic(
        A_WIDTH         : integer := 16;
        DEPTH           : vl_notype;
        D_WIDTH         : integer := 24
    );
    port(
        clk             : in     vl_logic;
        cs              : in     vl_logic;
        we              : in     vl_logic;
        addr            : in     vl_logic_vector;
        w_data          : in     vl_logic_vector;
        r_data          : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of A_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of DEPTH : constant is 3;
    attribute mti_svvh_generic_type of D_WIDTH : constant is 1;
end single_port_RAM;
