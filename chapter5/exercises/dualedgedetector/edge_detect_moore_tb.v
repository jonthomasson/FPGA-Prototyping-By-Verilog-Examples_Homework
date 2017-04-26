`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:12:02 08/28/2016
// Design Name:   dual_edge_detect_moore
// Module Name:   C:/Users/Stache/Documents/Xilinx Projects/learning/chapter5/exercises/dualedgedetector/edge_detect_moore_tb.v
// Project Name:  dualedgedetector
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: dual_edge_detect_moore
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module dual_edge_detect_moore_tb;

	// Inputs
	reg clk;
	reg reset;
	reg level;

	// Outputs
	wire tick;
	
	//  declaration
   localparam  T=20; // clock period

	// Instantiate the Unit Under Test (UUT)
	dual_edge_detect_moore uut (
		.clk(clk), 
		.reset(reset), 
		.level(level), 
		.tick(tick)
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
		level = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		reset = 1'b1;
		#(T/2);
		reset = 1'b0;
	  
		level = 1;
		#100;
		level = 0;
		#50;
		level = 1;
		#50; 
		level = 0;
		#100;
	end
      
endmodule

