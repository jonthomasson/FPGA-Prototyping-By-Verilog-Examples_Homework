// Listing 3.15
module bcd_to_sseg_test
   (
     input wire clk,
     input wire [7:0] sw,
     output wire [3:0] an,
     output wire [7:0] seg
   );

   // signal declaration
   wire [7:0] inc;
   wire [7:0] led0, led1, led2, led3;

   // increment input
   assign inc = sw + 1;

   // instantiate four instances of bcd decoders
   // instance for 4 LSBs of input
   bcd_to_sseg sseg_unit_0
      (.bcd(sw[3:0]), .dp(1'b1), .seg(led0));
   // instance for 4 MSBs of input
   bcd_to_sseg sseg_unit_1
      (.bcd(sw[7:4]), .dp(1'b1), .seg(led1));
   // instance for 4 LSBs of incremented value
   bcd_to_sseg sseg_unit_2
      (.bcd(inc[3:0]), .dp(1'b1), .seg(led2));
   // instance for 4 MSBs of incremented value
   bcd_to_sseg sseg_unit_3
      (.bcd(inc[7:4]), .dp(1'b1), .seg(led3));

   // instantiate 7-seg LED display time-multiplexing module
   disp_mux disp_unit
      (.clk(clk), .reset(1'b0), .in0(led2), .in1(led3),
       .in2(led0), .in3(led1), .an(an), .seg(seg));

endmodule