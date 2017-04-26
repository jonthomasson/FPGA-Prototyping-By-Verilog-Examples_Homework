`timescale 1ns / 10ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:46:08 08/22/2016
// Design Name:   square_wave
// Module Name:   C:/Users/Stache/Documents/Xilinx Projects/learning/chapter4/square_wave_generator/square_wave_tb.v
// Project Name:  square_wave_generator
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: square_wave
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module square_wave_tb;

	// Inputs
	reg clk;
	reg [3:0] m;
	reg [3:0] n;
	localparam T=20;

	// Outputs
	wire sw;

	// Instantiate the Unit Under Test (UUT)
	square_wave uut (
		.clk(clk), 
		.m(m), 
		.n(n), 
		.sw(sw)
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
		m = 4'b0001;
		n = 4'b0001;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

