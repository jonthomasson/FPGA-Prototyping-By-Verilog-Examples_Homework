`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:05:20 08/28/2016 
// Design Name: 
// Module Name:    dual_edge_detect_moore 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module dual_edge_detect_moore(
    input wire clk, reset,
    input wire level,
    output reg tick
   );

   // symbolic state declaration
   localparam [1:0]
      zero = 2'b00,
      rise = 2'b01,
      one = 2'b10,
		fall = 2'b11;

   // signal declaration
   reg [1:0] state_reg, state_next;

   // state register
    always @(posedge clk, posedge reset)
       if (reset)
          state_reg <= zero;
       else
          state_reg <= state_next;

   // next-state logic and output logic
   always @*
   begin
      state_next = state_reg;  // default state: the same
      tick = 1'b0;             // default output: 0
      case (state_reg)
         zero:
            if (level)
               state_next = rise;
         rise:
            begin
               tick = 1'b1;
               if (level)
                  state_next = one;
               else
                  state_next = fall;
             end
         one:
            if (~level)
               state_next = fall;
			fall:
            begin
					tick = 1'b1;
					if(level)
						state_next = rise;
					else
						state_next = zero;
				end
         default: state_next = zero;
      endcase
   end
endmodule
