// Listing 3.14
module bcd_to_sseg
   (
    input wire [3:0] bcd,
    input wire dp,
    output reg [7:0] seg  // output active low
   );

   always @*
   begin
      case(bcd)
         4'b0000: seg[6:0] = 7'b1000000;
         4'b0001: seg[6:0] = 7'b1001111;
         4'b0010: seg[6:0] = 7'b0100100;
         4'b0011: seg[6:0] = 7'b0110000;
         4'b0100: seg[6:0] = 7'b0011001;
         4'b0101: seg[6:0] = 7'b0010010;
         4'b0110: seg[6:0] = 7'b0000010;
         4'b0111: seg[6:0] = 7'b1111000;
         4'b1000: seg[6:0] = 7'b0000000;
         4'b1001: seg[6:0] = 7'b0010000;
         default: seg[6:0] = 7'b1000000;  //4'b0
     endcase
     seg[7] = dp;
   end

endmodule