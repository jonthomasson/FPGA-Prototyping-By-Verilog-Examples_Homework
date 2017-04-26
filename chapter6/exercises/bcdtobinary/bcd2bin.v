`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:54:18 09/10/2016 
// Design Name: 
// Module Name:    bcd2bin 
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
module bcd2bin(
	 input wire clk, reset,
    input wire start,
	 input wire [3:0] bcd1, bcd0,
    output wire [6:0] bin,
    output reg ready, done_tick
    );

   // symbolic state declaration
   localparam [1:0]
      idle = 2'b00,
      op   = 2'b01,
      done = 2'b10;

   // signal declaration
   reg [1:0] state_reg, state_next;
   reg [3:0] tens_reg, tens_reg_next;
   reg [6:0] bin_reg, bin_reg_next;
	
	
   // body
   // FSMD state & data registers
   always @(posedge clk, posedge reset)
      if (reset)
         begin
            state_reg <= idle;
            tens_reg <= 0;
            bin_reg <= 0;
         end
      else
         begin
            state_reg <= state_next;
            tens_reg <= tens_reg_next;
				bin_reg <= bin_reg_next;
         end
			
   // FSMD next-state logic
   always @*
   begin
      state_next = state_reg;
      ready = 1'b0;
      done_tick = 1'b0;
      tens_reg_next = tens_reg;
		bin_reg_next = bin_reg;
		
      case (state_reg)
         idle:
            begin
               ready = 1'b1;
               if (start)
                  begin
                     state_next = op;
                     tens_reg_next = bcd1;
							bin_reg_next = bcd0;
                  end
            end
         op:
            begin
					if(tens_reg_next == 0)
					begin
						state_next = done;
					end
					else
					begin
						bin_reg_next = bin_reg + 10;
						tens_reg_next = tens_reg - 1;
					end
            end
         done:
            begin
               done_tick = 1'b1;
               state_next = idle;
            end
         default: state_next = idle;
      endcase
   end

//   // data path function units
//   assign bcd0_tmp = (bcd0_reg > 4) ? bcd0_reg+3 : bcd0_reg;
//   assign bcd1_tmp = (bcd1_reg > 4) ? bcd1_reg+3 : bcd1_reg;
//   assign bcd2_tmp = (bcd2_reg > 4) ? bcd2_reg+3 : bcd2_reg;
//   assign bcd3_tmp = (bcd3_reg > 4) ? bcd3_reg+3 : bcd3_reg;
//
//   // output
//   assign bcd0 = bcd0_reg;
//   assign bcd1 = bcd1_reg;
//   assign bcd2 = bcd2_reg;
//   assign bcd3 = bcd3_reg;
	
	assign bin = bin_reg;
	
endmodule
