// Listing 14.4
module text_screen_gen
   (
    input wire clk, btn_set, btn_up, btn_down, btn_right, btn_left,
    input wire video_on,
    input wire [6:0] sw,
    input wire [9:0] pixel_x, pixel_y,
    output reg [2:0] text_rgb
   );

   // signal declaration
   // font ROM
   wire [14:0] rom_addr;
   wire [6:0] char_addr;
   wire [7:0] row_addr;
   wire [2:0] bit_addr;
   wire [7:0] font_word;
   wire font_bit;
   // tile RAM
   wire we;
   wire [9:0] addr_r, addr_w;
   wire [6:0] din, dout;
   // 80-by-7 tile map
   localparam MAX_X = 80;
   localparam MAX_Y = 7;
   // cursor
   reg [6:0] cur_x_reg;
   wire [6:0] cur_x_next;
   reg [2:0] cur_y_reg;
   wire [2:0]cur_y_next;
   wire move_right_tick, move_down_tick, move_up_tick, move_left_tick, cursor_on;
   // delayed pixel count
   reg [9:0] pix_x1_reg, pix_y1_reg;
   reg [9:0] pix_x2_reg, pix_y2_reg;
   // object output signals
   wire [2:0] font_rgb, font_rev_rgb;

   // body
   // instantiate debounce circuit for two buttons
   debounce deb_unit0
      (.clk(clk), .reset(), .sw(btn_right),
       .db_level(), .db_tick(move_right_tick));
   debounce deb_unit1
      (.clk(clk), .reset(), .sw(btn_down),
       .db_level(), .db_tick(move_down_tick));
	debounce deb_unit2
      (.clk(clk), .reset(), .sw(btn_left),
       .db_level(), .db_tick(move_left_tick));
   debounce deb_unit3
      (.clk(clk), .reset(), .sw(btn_up),
       .db_level(), .db_tick(move_up_tick));
		 
   // instantiate font ROM
   font_rom font_unit
      (.clk(clk), .addr(rom_addr), .data(font_word));
   // instantiate dual-port video RAM (2^10-by-7)
   xilinx_dual_port_ram_sync
      #(.ADDR_WIDTH(10), .DATA_WIDTH(7)) video_ram
      (.clk(clk), .we(we), .addr_a(addr_w), .addr_b(addr_r),
       .din_a(din), .dout_a(), .dout_b(dout));

   // registers
   always @(posedge clk)
      begin
         cur_x_reg <= cur_x_next;
         cur_y_reg <= cur_y_next;
         pix_x1_reg <= pixel_x;
         pix_x2_reg <= pix_x1_reg;
         pix_y1_reg <= pixel_y;
         pix_y2_reg <= pix_y1_reg;
      end
   // tile RAM write
   assign addr_w = {cur_y_reg, cur_x_reg};
   assign we = btn_set;
   assign din = sw;
   // tile RAM read
   // use nondelayed coordinates to form tile RAM address
   assign addr_r = {pixel_y[9:6], pixel_x[9:3]};
   assign char_addr = dout;
   // font ROM
   assign row_addr = pixel_y[7:0];
   assign rom_addr = {char_addr, row_addr};
   // use delayed coordinate to select a bit
   assign bit_addr = pix_x2_reg[2:0];
   assign font_bit = font_word[~bit_addr];
   // new cursor position
   assign cur_x_next =
      (move_right_tick && (cur_x_reg==MAX_X-1)) ? 0 : // wrap
      (move_right_tick) ? cur_x_reg + 1 :
      (move_left_tick) ? cur_x_reg - 1 :               
			cur_x_reg;
   assign cur_y_next =
      (move_down_tick && (cur_y_reg==MAX_Y-1)) ? 0 : // wrap
      (move_down_tick) ? cur_y_reg + 1 :
		(move_up_tick) ? cur_y_reg - 1 : 
                      cur_y_reg;
							 
   // object signals
   // green over black and reversed video for cursor
   assign font_rgb = (font_bit) ? 3'b010 : 3'b000;
   assign font_rev_rgb = (font_bit) ? 3'b000 : 3'b010;
   // use delayed coordinates for comparison
   assign cursor_on = (pix_y2_reg[9:6]==cur_y_reg) &&
                      (pix_x2_reg[9:3]==cur_x_reg);
   // rgb multiplexing circuit
   always @*
      if (~video_on)
         text_rgb = 3'b000; // blank
      else
         if (cursor_on)
            text_rgb = font_rev_rgb;
          else
            text_rgb = font_rgb;
endmodule

