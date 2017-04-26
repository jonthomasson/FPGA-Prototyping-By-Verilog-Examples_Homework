`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:34:56 09/02/2016 
// Design Name: 
// Module Name:    counter 
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
module counter(
	 input wire clk, reset,
    input wire inc,dec,
    output wire[7:0] count
    );
	 
   // signal declaration
   reg [7:0]  b_reg = 8'b00000000;
   wire [7:0] b_next;
	 
   always @(posedge clk, posedge reset)
      begin
			if(reset)
				b_reg <= 8'b00000000;
			else
				b_reg <= b_next;
      end
   assign b_next = (inc) ? b_reg + 1 : 
							(dec) ? b_reg - 1 : b_reg;
 
	assign count = b_reg;

endmodule
