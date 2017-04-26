`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    06:04:03 08/25/2016 
// Design Name: 
// Module Name:    pwm_led_test 
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
// Listing 4.19
module pwm_led_test
   (
    input wire clk,
	 input wire [3:0] sw,
    output wire [7:0] Led
   );

  
   // instantiate LEDs
   pwm_led test_led
      (.clk(clk), .LED(Led[0]),
       .PWM_input(sw[3:0]));
		 
   pwm_led test_led0
      (.clk(clk), .LED(Led[1]),
       .PWM_input(sw[3:0]));

   pwm_led test_led1
      (.clk(clk), .LED(Led[2]),
       .PWM_input(sw[3:0]));
		 
   pwm_led test_led2
      (.clk(clk), .LED(Led[3]),
       .PWM_input(sw[3:0]));
		 
   pwm_led test_led3
      (.clk(clk), .LED(Led[4]),
       .PWM_input(sw[3:0]));
		 
   pwm_led test_led4
      (.clk(clk), .LED(Led[5]),
       .PWM_input(sw[3:0]));
		 
   pwm_led test_led5
      (.clk(clk), .LED(Led[6]),
       .PWM_input(sw[3:0]));
		 
   pwm_led test_led6
      (.clk(clk), .LED(Led[7]),
       .PWM_input(sw[3:0]));

endmodule
