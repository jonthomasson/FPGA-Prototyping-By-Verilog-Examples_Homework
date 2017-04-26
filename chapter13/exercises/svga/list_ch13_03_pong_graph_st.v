// Listing 13.3
module pong_graph_st
   (
    input wire video_on,
    input wire [9:0] pix_x, pix_y,
    output reg [2:0] graph_rgb
   );

   
   //--------------------------------------------
   // object output signals
   //--------------------------------------------
   wire grid_on;
   wire [2:0] grid_rgb;

   // body
   //--------------------------------------------
   // (grid) 
   //--------------------------------------------
   
	assign grid_on = (pix_x % 100 == 0) || (pix_y % 100 == 0); //if either x or y pixel is divisible by 100 then turn pixel on

   // rgb output
   
	assign grid_rgb = 3'b001;

   //--------------------------------------------
   // rgb multiplexing circuit
   //--------------------------------------------
   always @*
      if (~video_on)
         graph_rgb = 3'b000; // blank
      else
         if (grid_on)
            graph_rgb = grid_rgb;
         else
            graph_rgb = 3'b000; // black background

endmodule