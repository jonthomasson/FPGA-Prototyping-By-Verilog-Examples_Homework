//Listing 8.5
module uart_test
   (
    input wire clk, reset, sw0dbit, sw1sbit,
	 input wire [1:0] swbaud, swparity,
    input wire rx, 
    input wire [2:0] btn,
	 
    output wire tx,
    output wire [3:0] an,
    output wire [7:0] sseg, led
   );

   // signal declaration
   wire tx_full, rx_empty, btn_tick;
   wire [7:0] rec_data, rec_data1;
	wire [2:0] error;
	reg master_clk; //50mhz clock
	reg [2:0]curr_error; //current error
	

   // body
   // instantiate uart
   uart uart_unit
      (.clk(master_clk), .reset(reset), .rd_uart(btn_tick),
       .wr_uart(btn_tick), .rx(rx), .w_data(rec_data1),
       .tx_full(tx_full), .rx_empty(rx_empty),
       .r_data(rec_data), .tx(tx), .d_num(sw0dbit), .s_num(sw1sbit), .bd_rate(swbaud[1:0]), .par(swparity[1:0]), .err(error));
   // instantiate debounce circuit
   debounce btn_db_unit
      (.clk(master_clk), .reset(reset), .sw(btn[0]),
       .db_level(), .db_tick(btn_tick));
   // incremented data loops back
   assign rec_data1 = rec_data + 1;
   // LED display
   //assign led = rec_data ; //uncomment to assign leds to data input instead of error
	assign led = curr_error;  //uncomment to see error codes on led

   assign an = 4'b1110;
   assign sseg = {1'b1, ~tx_full, 2'b11, ~rx_empty, 3'b111};
	
	always @(posedge clk, posedge reset)
	begin
		if(reset)
		begin
			curr_error <= 0;
		end
		else
		begin
			if(error != 3'b000) //if there's a new error, assign it to current error register
				curr_error <= error;
				
			master_clk <= master_clk + 1; //effectively cuts 100MHz clock in half.
		end
      
		
	end
	
endmodule