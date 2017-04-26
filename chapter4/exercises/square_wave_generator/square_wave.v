`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jon Thomasson (AKA STACHE)
// 
// Create Date:    08:13:19 08/20/2016 
// Design Name: 
// Module Name:    square_wave 
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
module square_wave(
		input wire clk,
		input wire[3:0] m, n, //control signals. m= on duration (aka duty cycle), n = off duration (period).
		output wire sw //square wave output
    );

	//signal declaration
   localparam  T=20; //clock period 20ns
	reg sw_reg; //current state register

	reg [11:0]  counter;
	
   //body
   //register

	always @(posedge clk)
     begin
        if (counter == (n * 100)) // period, count from 0 to n-1
          counter <= 0;
        else
          counter <= counter + 1'b1;

        // synchronous output without glitches
        if (counter < (m * 100)) // duty cycle, m cycles high
          sw_reg = 1'b1;
        else
          sw_reg = 1'b0;
      end
								
	//output logic
	assign sw = sw_reg;
endmodule
