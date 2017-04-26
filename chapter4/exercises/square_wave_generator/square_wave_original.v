`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
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
		input wire[3:0] m, n, //control signals. m= on duration (aka duty cycle), n = off duration (frequency).
		output wire sw //square wave output
    );

	//signal declaration
   localparam  T=20; //clock period 20ns
	reg sw_reg; //current state register
	wire sw_next; //next state register
	wire sw_tick; //shows whether the square wave is currently on or off
	reg [10:0] sw_counter; //11 bit counter(0-1500) for on/off square wave timing.

   //body
   //register
   always @(posedge clk)
   begin
		sw_reg <= sw_next;
   end

   // next-state logic
	assign sw_next = sw_tick ? 1'b1 : 1'b0;
	assign sw_tick = (sw_tick && sw_counter == (m * 100)) ? 1'b0 : 			//if sw_tick is on and duration met, then 0
								(~sw_tick && sw_counter == (n * 100)) ? 1'b1 :  	//else if sw_tick is off and duration met, then 1
								sw_tick ; 														//else stay the same
				
	//other ways I could maybe do this: just use # to pause the execution for a given time period?
	always@*
	begin
		if(sw_tick)
		begin
			if(sw_counter < (m*100))
				sw_counter = sw_counter + 1;
			else
				sw_counter = 0;
		end
		else if(~sw_tick)
		begin
			if(sw_counter < (n*100))
				sw_counter = sw_counter + 1;
			else
				sw_counter = 0;
		end
	end
								
	//output logic
	assign sw = sw_reg;
endmodule
