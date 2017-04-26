`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    06:02:36 08/25/2016 
// Design Name: 
// Module Name:    pwm_led 
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
module pwm_led(clk, PWM_input, LED);
input clk;
input [3:0] PWM_input;     // 16 intensity levels
output LED;

reg [4:0] PWM;
always @(posedge clk) PWM <= PWM[3:0]+PWM_input;

assign LED = PWM[4];
endmodule
