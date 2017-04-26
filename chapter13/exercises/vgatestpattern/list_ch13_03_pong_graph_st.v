// Listing 13.3
module pong_graph_st
   (
    input wire video_on,
    input wire [9:0] pix_x, pix_y,
    output reg [2:0] graph_rgb
   );

   // constant and signal declaration
   // x, y coordinates (0,0) to (639,479)
   localparam MAX_X = 640;
   localparam MAX_Y = 480;
   //--------------------------------------------
   // bar 1
   //--------------------------------------------
   // bar1 left, right boundary
   localparam BAR1_V_X_L = 0;
   localparam BAR1_V_X_R = 79;
   //--------------------------------------------
   // bar 2
   //--------------------------------------------
   // bar2 left, right boundary
   localparam BAR2_V_X_L = 80;
   localparam BAR2_V_X_R = 160;
   //--------------------------------------------
   // bar 3
   //--------------------------------------------
   // bar3 left, right boundary
   localparam BAR3_V_X_L = 161;
   localparam BAR3_V_X_R = 241;
   //--------------------------------------------
   // bar 4
   //--------------------------------------------
   // bar4 left, right boundary
   localparam BAR4_V_X_L = 242;
   localparam BAR4_V_X_R = 322;
   //--------------------------------------------
   // bar 5
   //--------------------------------------------
   // bar5 left, right boundary
   localparam BAR5_V_X_L = 323;
   localparam BAR5_V_X_R = 403;
   //--------------------------------------------
   // bar 6
   //--------------------------------------------
   // bar6 left, right boundary
   localparam BAR6_V_X_L = 404;
   localparam BAR6_V_X_R = 484;
   //--------------------------------------------
   // bar 7
   //--------------------------------------------
   // bar7 left, right boundary
   localparam BAR7_V_X_L = 485;
   localparam BAR7_V_X_R = 565;
   //--------------------------------------------
   // bar 8
   //--------------------------------------------
   // bar8 left, right boundary
   localparam BAR8_V_X_L = 566;
   localparam BAR8_V_X_R = 640;
//   //--------------------------------------------
//   // right vertical bar
//   //--------------------------------------------
//   // bar left, right boundary
//   localparam BAR_X_L = 600;
//   localparam BAR_X_R = 603;
//   // bar top, bottom boundary
//   localparam BAR_Y_SIZE = 72;
//   localparam BAR_Y_T = MAX_Y/2-BAR_Y_SIZE/2; //204
//   localparam BAR_Y_B = BAR_Y_T+BAR_Y_SIZE-1;
//   //--------------------------------------------
//   // square ball
//   //--------------------------------------------
//   localparam BALL_SIZE = 8;
//   // ball left, right boundary
//   localparam BALL_X_L = 580;
//   localparam BALL_X_R = BALL_X_L+BALL_SIZE-1;
//   // ball top, bottom boundary
//   localparam BALL_Y_T = 238;
//   localparam BALL_Y_B = BALL_Y_T+BALL_SIZE-1;
   //--------------------------------------------
   // object output signals
   //--------------------------------------------
   wire bar1_on, bar2_on, bar3_on, bar4_on, bar5_on, bar6_on, bar7_on, bar8_on;
   wire [2:0] bar1_rgb, bar2_rgb, bar3_rgb, bar4_rgb, bar5_rgb, bar6_rgb, bar7_rgb, bar8_rgb;

   // body
   //--------------------------------------------
   // (wall) left vertical strip
   //--------------------------------------------
   // pixel within wall
   assign bar1_on = (BAR1_V_X_L<=pix_x) && (pix_x<=BAR1_V_X_R);
	assign bar2_on = (BAR2_V_X_L<=pix_x) && (pix_x<=BAR2_V_X_R);
	assign bar3_on = (BAR3_V_X_L<=pix_x) && (pix_x<=BAR3_V_X_R);
	assign bar4_on = (BAR4_V_X_L<=pix_x) && (pix_x<=BAR4_V_X_R);
	assign bar5_on = (BAR5_V_X_L<=pix_x) && (pix_x<=BAR5_V_X_R);
	assign bar6_on = (BAR6_V_X_L<=pix_x) && (pix_x<=BAR6_V_X_R);
	assign bar7_on = (BAR7_V_X_L<=pix_x) && (pix_x<=BAR7_V_X_R);
	assign bar8_on = (BAR8_V_X_L<=pix_x) && (pix_x<=BAR8_V_X_R);


   // wall rgb output
   assign bar1_rgb = 3'b001; // red
	assign bar2_rgb = 3'b010; // green
	assign bar3_rgb = 3'b011; 
	assign bar4_rgb = 3'b100; 
	assign bar5_rgb = 3'b101; 
	assign bar6_rgb = 3'b110; 
	assign bar7_rgb = 3'b111; 
	assign bar8_rgb = 3'b000; 


//   //--------------------------------------------
//   // right vertical bar
//   //--------------------------------------------
//   // pixel within bar
//   assign bar_on = (BAR_X_L<=pix_x) && (pix_x<=BAR_X_R) &&
//                   (BAR_Y_T<=pix_y) && (pix_y<=BAR_Y_B);
//   // bar rgb output
//   assign bar_rgb = 3'b010; // green
//   //--------------------------------------------
//   // square ball
//   //--------------------------------------------
//   // pixel within squared ball
//   assign sq_ball_on =
//             (BALL_X_L<=pix_x) && (pix_x<=BALL_X_R) &&
//             (BALL_Y_T<=pix_y) && (pix_y<=BALL_Y_B);
//   assign ball_rgb = 3'b100;   // red
   //--------------------------------------------
   // rgb multiplexing circuit
   //--------------------------------------------
   always @*
      if (~video_on)
         graph_rgb = 3'b000; // blank
      else
         if (bar1_on)
            graph_rgb = bar1_rgb;
         else if (bar2_on)
            graph_rgb = bar2_rgb;
			else if (bar3_on)
            graph_rgb = bar3_rgb;
			else if (bar4_on)
            graph_rgb = bar4_rgb;
			else if (bar5_on)
            graph_rgb = bar5_rgb;
			else if (bar6_on)
            graph_rgb = bar6_rgb;
			else if (bar7_on)
            graph_rgb = bar7_rgb;
			else if (bar8_on)
            graph_rgb = bar8_rgb;
         else
            graph_rgb = 3'b110; // yellow background

endmodule