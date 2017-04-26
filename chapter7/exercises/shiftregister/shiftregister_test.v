`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:02:09 09/13/2016
// Design Name:   shiftregister
// Module Name:   C:/Users/Stache/Documents/Xilinx Projects/learning/chapter7/exercises/shiftregister/shiftregister_test.v
// Project Name:  shiftregister
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: shiftregister
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module shiftregister_test;

	// Inputs
	reg clk;
	reg x0;
	reg y0;
	reg z0;

	// Outputs
	wire x3;
	wire y3;
	wire z3;
	
	//  declaration
   localparam  T=20; // clock period

	// Instantiate the Unit Under Test (UUT)
	shiftregister uut (
		.clk(clk), 
		.x0(x0), 
		.y0(y0), 
		.z0(z0), 
		.x3(x3), 
		.y3(y3), 
		.z3(z3)
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
		x0 = 0;
		y0 = 0;
		z0 = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		x0 = 1;
		y0 = 1;
		z0 = 1;
		#20;
		x0 = 0;
		y0 = 0;
		z0 = 0;
		#20;
		x0 = 1;
		y0 = 1;
		z0 = 1;
		#20;
		x0 = 0;
		y0 = 0;
		z0 = 0;
		#20;
		x0 = 1;
		y0 = 1;
		z0 = 1;
		
		$stop;

	end
      
endmodule

