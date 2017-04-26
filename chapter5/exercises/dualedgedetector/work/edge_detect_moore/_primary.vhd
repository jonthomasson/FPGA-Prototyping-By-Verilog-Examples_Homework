library verilog;
use verilog.vl_types.all;
entity edge_detect_moore is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        level           : in     vl_logic;
        tick            : out    vl_logic
    );
end edge_detect_moore;
