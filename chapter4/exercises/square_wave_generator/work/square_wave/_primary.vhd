library verilog;
use verilog.vl_types.all;
entity square_wave is
    port(
        clk             : in     vl_logic;
        m               : in     vl_logic_vector(3 downto 0);
        n               : in     vl_logic_vector(3 downto 0);
        sw              : out    vl_logic
    );
end square_wave;
