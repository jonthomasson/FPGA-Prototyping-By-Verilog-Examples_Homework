library verilog;
use verilog.vl_types.all;
entity counter is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        inc             : in     vl_logic;
        dec             : in     vl_logic;
        count           : out    vl_logic_vector(7 downto 0)
    );
end counter;
