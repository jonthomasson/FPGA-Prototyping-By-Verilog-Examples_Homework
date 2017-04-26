library verilog;
use verilog.vl_types.all;
entity bcd2bin is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        start           : in     vl_logic;
        bcd1            : in     vl_logic_vector(3 downto 0);
        bcd0            : in     vl_logic_vector(3 downto 0);
        bin             : out    vl_logic_vector(6 downto 0);
        ready           : out    vl_logic;
        done_tick       : out    vl_logic
    );
end bcd2bin;
