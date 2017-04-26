`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   06:52:44 09/02/2016
// Design Name:   occupancy_counter
// Module Name:   C:/Users/Stache/Documents/Xilinx Projects/learning/chapter5/exercises/occupancycounter/occupancy_counter_tb.v
// Project Name:  occupancycounter
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: occupancy_counter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module occupancy_counter_tb;

	//  declaration
   localparam  T=20; // clock period
	
	// Inputs
	reg clk;
	reg a;
	reg b;

	// Outputs
	wire enter;
	wire exit;

	// Instantiate the Unit Under Test (UUT)
	occupancy_counter uut (
		.clk(clk), 
		.a(a), 
		.b(b), 
		.enter(enter), 
		.exit(exit)
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
		a = 0;
		b = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		a = 1; //car entering lot enter_1
		#200;
		b = 1; //enter_2
		#200;	 
		a = 0; //enter_3
		#200;
		b = 0; //clear
		#200;
		
		b = 1;  //exit_1
		#200;
		a = 1;  //exit_2
		#200;
		b = 0;  //exit_3
		#200;
		a = 0;  //clear
		
		
	end
      
endmodule

