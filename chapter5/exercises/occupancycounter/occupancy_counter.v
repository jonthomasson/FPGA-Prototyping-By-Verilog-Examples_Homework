`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jon Thomasson aka St@ch3
// 
// Create Date:    16:01:53 09/01/2016 
// Design Name: 
// Module Name:    occupancy_counter 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: counts cars in a parking lot based off the count of them entering
//					 and leaving.
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module occupancy_counter(
input wire clk, 
    input wire a,b,
    output reg enter,exit
    );

// symbolic state declaration
	 localparam  [2:0]
    clear    = 3'b000,
    enter_1  = 3'b001,
    enter_2  = 3'b010,
    enter_3  = 3'b011,
    exit_1   = 3'b100,
	 exit_2   = 3'b101,
    exit_3   = 3'b110;
	 
	 reg [2:0] state_reg, state_next;
	 
   // state register
    always @(posedge clk)
          state_reg <= state_next;
	 
// next-state logic and output logic
   always @*
   begin
      state_next = state_reg;  // default state: the same
      enter = 1'b0;               // default output: 0
		exit = 1'b0;               // default output: 0

      case (state_reg)
			clear:
            if (a)
               state_next = enter_1;
				else
				if(b)
					state_next = exit_1;
         enter_1:
            begin
              if (~a)
                 state_next = clear;
				  else
              if (b)
                 state_next = enter_2;
            end
			enter_2:
				begin
					if(~a && b)
						state_next = enter_3;
				end
			enter_3:	
				begin
					if(~b)
					begin
						enter = 1'b1;
						state_next = clear;
					end
				end
			exit_1:
				begin
					if(~b)
						state_next = clear;
					else
					if(a)
						state_next = exit_2;
				end
			exit_2:
				begin
					if(~b && a)
						state_next = exit_3;
				end
			exit_3:
				begin
					if(~a)
					begin
						exit = 1'b1;
						state_next = clear;
					end
				end
			default: state_next = clear;
		endcase
	end

endmodule
