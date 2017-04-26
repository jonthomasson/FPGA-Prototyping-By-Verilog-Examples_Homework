library verilog;
use verilog.vl_types.all;
entity shiftregister is
    port(
        clk             : in     vl_logic;
        x0              : in     vl_logic;
        y0              : in     vl_logic;
        z0              : in     vl_logic;
        x3              : out    vl_logic;
        y3              : out    vl_logic;
        z3              : out    vl_logic
    );
end shiftregister;
