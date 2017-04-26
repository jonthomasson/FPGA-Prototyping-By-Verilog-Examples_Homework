`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   06:32:03 09/11/2016
// Design Name:   bcd2bin
// Module Name:   C:/Users/Stache/Documents/Xilinx Projects/learning/chapter6/exercises/bcdtobinary/bcd2bin_tb.v
// Project Name:  bcdtobinary
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: bcd2bin
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module bcd2bin_tb;

	// Inputs
	reg clk;
	reg reset;
	reg start;
	reg [3:0] bcd1;
	reg [3:0] bcd0;

	// Outputs
	wire [6:0] bin;
	wire ready;
	wire done_tick;
	localparam  T=20; // clock period
	// Instantiate the Unit Under Test (UUT)
	bcd2bin uut (
		.clk(clk), 
		.reset(reset), 
		.start(start), 
		.bcd1(bcd1), 
		.bcd0(bcd0), 
		.bin(bin), 
		.ready(ready), 
		.done_tick(done_tick)
	);
	
	// clock
   // 20 ns clock running forever
   always
   begin
      clk = 1'b1;
      #(T/2);
      clk = 1'b0;
      #(T/2);
   end


	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		start = 0;
		bcd1 = 0;
		bcd0 = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		bcd1 = 4'b1001;
		bcd0 = 4'b0111;
		
		start = 1;
		#50;
		start = 0;
	end
      
endmodule

