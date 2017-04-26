//Listing 8.5
module uart_test
   (
    input wire clk, reset,
    input wire rx,
    output wire [7:0]  led,
	  output wire hsync, vsync,
    output wire [2:0] rgb
   );

   // signal declaration
   wire tx_full, rx_empty, rx_done;
   wire [7:0] rec_data;
	reg master_clk; //50mhz clock
	 wire [9:0] pixel_x, pixel_y;
   wire video_on, pixel_tick;
   reg [2:0] rgb_reg;
   wire [2:0] rgb_next;

   // body
   // instantiate uart
   uart uart_unit
      (.clk(master_clk), .reset(reset), .rd_uart(),
       .wr_uart(), .rx(rx), .w_data(),
       .tx_full(tx_full), .rx_empty(rx_empty),
       .r_data(rec_data), .tx(), .rx_done(rx_done));
		 
   // instantiate vga sync circuit
   vga_sync vsync_unit
      (.clk(master_clk), .reset(), .hsync(hsync), .vsync(vsync),
       .video_on(video_on), .p_tick(pixel_tick),
       .pixel_x(pixel_x), .pixel_y(pixel_y));
   // font generation circuit
   text_screen_gen text_gen_unit
      (.clk(master_clk), .video_on(video_on),
        .data(rec_data[6:0]), .text_rx_done(rx_done), .pixel_x(pixel_x),
       .pixel_y(pixel_y), .text_rgb(rgb_next));
		 
   // LED display
   assign led = rec_data;

   // rgb buffer
   always @(posedge clk)
      if (pixel_tick)
         rgb_reg <= rgb_next;
	
	always @(posedge clk)
      master_clk <= master_clk + 1;
	
   // output
   assign rgb = rgb_reg;
	
	
endmodule