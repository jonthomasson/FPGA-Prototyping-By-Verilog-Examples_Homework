// Listing 14.2
module font_test_gen
   (
    input wire clk,
    input wire video_on,
    input wire [9:0] pixel_x, pixel_y,
    output reg [2:0] rgb_text
   );

   // signal declaration
   wire [10:0] rom_addr;
   wire [6:0] char_addr;
   wire [3:0] row_addr;
   wire [2:0] bit_addr;
   wire [7:0] font_word;
   wire font_bit, text_bit_on;

   // body
   // instantiate font ROM
   font_rom font_unit
      (.clk(clk), .addr(rom_addr), .data(font_word));
   // font ROM interface
//   assign char_addr = {pixel_y[5:4], pixel_x[7:3]}; //uncomment for original size
   assign char_addr = {pixel_y[6:5], pixel_x[8:4]}; //uncomment for double size
//   assign row_addr = pixel_y[3:0]; //uncomment for original size
   assign row_addr = pixel_y[4:1]; //uncomment for double size
   assign rom_addr = {char_addr, row_addr};
//   assign bit_addr = pixel_x[2:0]; //uncomment for original size
   assign bit_addr = pixel_x[3:1]; //uncomment for double size
   assign font_bit = font_word[~bit_addr];
   // "on" region limited to top-left corner
//	assign text_bit_on = font_bit; //uncomment for whole screen
//   assign text_bit_on = (pixel_x[9:8]==0 && pixel_y[9:6]==0) ? //uncomment for original size
//                        font_bit : 1'b0;
   assign text_bit_on = (pixel_x[9]==0 && pixel_y[9:7]==0) ? //uncomment for double size
                        font_bit : 1'b0;
   // rgb multiplexing circuit
   always @*
      if (~video_on)
         rgb_text = 3'b000; // blank
      else
         if (text_bit_on)
            rgb_text = 3'b010;  // green
          else
            rgb_text = 3'b000;  // black

endmodule
