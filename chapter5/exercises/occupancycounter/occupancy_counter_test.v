`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jon Thomasson aka St@ch3
// 
// Create Date:    06:44:50 09/03/2016 
// Design Name: 
// Module Name:    occupancy_counter_test 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: Test that wraps up the occupancy_counter, counter, led multiplexer, and
//						debouncer circuit to make a finished product.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module occupancy_counter_test(
    input wire clk, reset,
    input wire [1:0] btn,
    output wire [3:0] an,
    output wire [7:0] sseg
    );

   // signal declaration
   wire [7:0] count_reg;
   wire enter_tick, exit_tick, db_a, db_b;

   // instantiate 7-seg LED display time-multiplexing module
   disp_hex_mux disp_unit
      (.clk(clk), .reset(reset),
       .hex3(count_reg[7:4]), .hex2(count_reg[3:0]),
       .hex1(count_reg[7:4]), .hex0(count_reg[3:0]),
       .dp_in(4'b1011), .an(an), .sseg(sseg));

   // instantiate debouncing circuit
   db_fsm db_unit1
      (.clk(clk), .reset(reset), .sw(btn[0]), .db(db_a));
		
	db_fsm db_unit2
      (.clk(clk), .reset(reset), .sw(btn[1]), .db(db_b));
	
	//occupancy counter module
	occupancy_counter occ
		(.clk(clk), .a(db_a), .b(db_b), .enter(enter_tick), .exit(exit_tick));
	
	//counter module
	counter cnt
		(.clk(clk), .inc(enter_tick),.reset(reset), .dec(exit_tick), .count(count_reg));

endmodule
