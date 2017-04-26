//etch a sketch bitmap test
module bitmap_gen
   (
    input wire clk, reset,
    input wire video_on,
    input btn_up, btn_down, btn_right, btn_left,
    input [2:0] sw,
    input wire [9:0] pix_x, pix_y,
    output reg [2:0] bit_rgb
   );

   // constant and signal declaration
   wire go_up, go_down, go_right, go_left;
   //--------------------------------------------
   // video sram
   //--------------------------------------------
   wire we;
   wire [13:0] addr_r, addr_w;
   wire [2:0] din, dout;
   //--------------------------------------------
   // dot location
   //--------------------------------------------
   // reg to keep track of dot location
   reg [6:0] dot_x_reg, dot_y_reg;
   wire [6:0] dot_x_next, dot_y_next;
   //--------------------------------------------
   // object output signals
   //--------------------------------------------
   wire bitmap_on;
   wire [2:0] bitmap_rgb;

   // body
   // instantiate debounce circuit for up/down/right/left buttons
   debounce deb_unit
      (.clk(clk), .reset(reset), .sw(btn_up),
       .db_level(), .db_tick(go_up));
		 
	debounce deb_unit2
      (.clk(clk), .reset(reset), .sw(btn_down),
       .db_level(), .db_tick(go_down));
		 
	debounce deb_unit3
      (.clk(clk), .reset(reset), .sw(btn_right),
       .db_level(), .db_tick(go_right));
		 
	debounce deb_unit4
      (.clk(clk), .reset(reset), .sw(btn_left),
       .db_level(), .db_tick(go_left));
		 
   // instantiate dual-port video RAM (2^12-by-7)
   xilinx_dual_port_ram_sync
      #(.ADDR_WIDTH(14), .DATA_WIDTH(3)) video_ram
      (.clk(clk), .we(we), .addr_a(addr_w), .addr_b(addr_r),
       .din_a(din), .dout_a(), .dout_b(dout));
		 
   // video ram interface
   assign addr_w = {dot_y_reg, dot_x_reg};
   assign addr_r = {pix_y[6:0], pix_x[6:0]};
   assign we = 1'b1;
   assign din = sw;
   assign bitmap_rgb = dout;
	
   // registers
   always @(posedge clk, posedge reset)
      if (reset)
         begin
            dot_x_reg <= 0;
            dot_y_reg <= 0;
         end
      else
         begin
            dot_x_reg <= dot_x_next;
            dot_y_reg <= dot_y_next;
         end


   // pixel within bit map area
   assign bitmap_on =(pix_x<=127) & (pix_y<=127);
	
   // dot position
   // "randomly" load dot location when btn[0] pressed
   assign dot_x_next = (go_left) ? dot_x_reg - 1 :
                       (go_right) ? dot_x_reg + 1 :
                       dot_x_reg ;
   assign dot_y_next = (go_up) ? dot_y_reg + 1 :
                       (go_down) ? dot_y_reg - 1 :
                       dot_y_reg ;

   //--------------------------------------------
   // rgb multiplexing circuit
   //--------------------------------------------
   always @*
      if (~video_on)
         bit_rgb = 3'b000; // blank
      else
         if (bitmap_on)
            bit_rgb = bitmap_rgb;
         else
            bit_rgb = 3'b110; // yellow background

endmodule
