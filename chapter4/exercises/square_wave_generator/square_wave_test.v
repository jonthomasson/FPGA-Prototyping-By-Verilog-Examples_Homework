`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jon Thomasson (AKA STACHE)
// 
// Create Date:    06:39:45 08/23/2016 
// Design Name: 
// Module Name:    square_wave_test 
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
module square_wave_test(
    input wire clk,
    input wire [7:0] switch,
	 output wire ja //square wave output pin
    );

   square_wave sw_unit
      (.clk(clk), .m(switch[7:4]), .n(switch[3:0]), .sw(ja));

  

endmodule
