library verilog;
use verilog.vl_types.all;
entity univ_bin_counter is
    generic(
        N               : integer := 8
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        syn_clr         : in     vl_logic;
        load            : in     vl_logic;
        en              : in     vl_logic;
        up              : in     vl_logic;
        d               : in     vl_logic_vector;
        max_tick        : out    vl_logic;
        min_tick        : out    vl_logic;
        q               : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
end univ_bin_counter;
