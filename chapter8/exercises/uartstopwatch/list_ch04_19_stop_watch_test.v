// Listing 4.19
module stop_watch_test
   (
    input wire clk, rx, reset,
    input wire [1:0] btn,
	 output wire tx,
    output wire [3:0] an,
    output wire [7:0] sseg
   );

   // signal declaration
   wire [3:0]  d2, d1, d0;
	reg master_clk; //50mhz clock
	reg go, clear;
	wire btn_tick;

   // instantiate 7-seg LED display module
   disp_hex_mux disp_unit
      (.clk(master_clk), .reset(1'b0),
       .hex3(4'b0), .hex2(d2), .hex1(d1), .hex0(d0),
       .dp_in(4'b1101), .an(an), .sseg(sseg));

   // instantiate stopwatch
   stop_watch_if counter_unit
      (.clk(master_clk), .go(go), .clr(clear),
       .d2(d2), .d1(d1), .d0(d0) );
		 
	// instantiate uart
   uart uart_unit
      (.clk(master_clk), .reset(reset), .rd_uart(btn_tick),
       .wr_uart(btn_tick), .rx(rx), .w_data(),
       .tx_full(), .rx_empty(),
       .r_data(rec_data), .tx(tx));
		 
   // instantiate debounce circuit
   debounce btn_db_unit
      (.clk(master_clk), .reset(reset), .sw(btn[0]),
       .db_level(), .db_tick(btn_tick));
		 
	always @(posedge clk)
	begin
      master_clk <= master_clk + 1; //50MHz clock 
		
		go <= 1'b0;
		clear <= 1'b0;

		case(rec_data)
			8'b01100111: //go
				go <= 1'b1;
			8'b01100011: //clear
				clear <= 1'b1;
		endcase
	end
		
//	always @*
//	begin
//		go = 1'b0;
//		clear = 1'b0;
//
//		case(rec_data)
//			8'b01100111: //go
//				go = 1'b1;
//			8'b01100011: //clear
//				clear = 1'b1;
//		endcase
//	end

endmodule
