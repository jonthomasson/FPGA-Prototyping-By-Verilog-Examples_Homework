`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:00:34 09/02/2016
// Design Name:   counter
// Module Name:   C:/Users/Stache/Documents/Xilinx Projects/learning/chapter5/exercises/occupancycounter/counter_tb.v
// Project Name:  occupancycounter
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: counter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module counter_tb;

	//  declaration
   localparam  T=20; // clock period
	// Inputs
	reg clk;
	reg inc;
	reg dec;
	reg [7:0] reg_count;
	// Outputs
	wire [7:0] count;

	// Instantiate the Unit Under Test (UUT)
	counter uut (
		.clk(clk), 
		.inc(inc), 
		.dec(dec), 
		.count(count)
	);
	
	// clock
   // 20 ns clock running forever
//   always
//   begin
//      clk = 1'b1;
//      #(T/2);
//      clk = 1'b0;
//      #(T/2);
//   end

//	assign count = reg_count;

	initial begin
		// Initialize Inputs
		clk = 0;
		inc = 0;
		dec = 0;
//		reg_count[7:0] = 8'b00000000;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		//first test increment;
		inc = 1;
		clk = 1;
		#10;
		clk = 0;
		#10;
		inc = 1;
		clk = 1;
		#10;
		clk = 0;
		#10;
		clk = 1;
		#10;
		clk = 0;
		#10;
		clk = 1;
		#10;
		clk = 0;
		//next test decrement.
		#10;
		inc = 0;
		dec = 1;
		clk = 1;
		#10;
		clk = 0;
		#10;
		clk = 1;
		#10;
		clk = 0;
		#10;
		clk = 1;
		#10;
		clk = 0;
	
		
	end
      
endmodule

