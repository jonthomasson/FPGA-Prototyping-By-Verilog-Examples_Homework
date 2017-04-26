library verilog;
use verilog.vl_types.all;
entity occupancy_counter is
    port(
        clk             : in     vl_logic;
        a               : in     vl_logic;
        b               : in     vl_logic;
        enter           : out    vl_logic;
        \exit\          : out    vl_logic
    );
end occupancy_counter;
