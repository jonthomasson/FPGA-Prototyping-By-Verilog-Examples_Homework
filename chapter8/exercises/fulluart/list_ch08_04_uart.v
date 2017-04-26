//Listing 8.4
module uart
   #( // Default setting:
      // 19,200 baud, 8 data bits, 1 stop bit, 2^2 FIFO
      parameter DBIT = 8,     // # data bits
                SB_TICK = 16, // # ticks for stop bits, 16/24/32
                              // for 1/1.5/2 stop bits
                DVSR = 163,   // baud rate divisor
                              // DVSR = 50M/(16*baud rate)
                DVSR_BIT = 12, // # bits of DVSR
                FIFO_W = 2    // # addr bits of FIFO
                              // # words in FIFO=2^FIFO_W
   )
   (
    input wire clk, reset,
    input wire rd_uart, wr_uart, rx, d_num, s_num,
    input wire [7:0] w_data,
	 input wire [1:0] bd_rate, par,
	 output wire [2:0] err,
    output wire tx_full, rx_empty, tx,
    output wire [7:0] r_data
   );

   // signal declaration
   wire tick, rx_done_tick, tx_done_tick;
   wire tx_empty, tx_fifo_not_empty, rx_full;
   wire [7:0] tx_fifo_out, rx_data_out;
	wire [3:0] databit;
	wire [5:0] stopbit;
	wire [11:0] baud;

   //body
   mod_m_counter #(.N(DVSR_BIT)) baud_gen_unit
      (.clk(clk), .reset(reset), .q(), .max_tick(tick), .m(baud));

   uart_rx uart_rx_unit
      (.clk(clk), .reset(reset), .rx(rx), .s_tick(tick), .dbit(databit), .sbit(stopbit),
       .rx_done_tick(rx_done_tick), .dout(rx_data_out), .par(par), .rx_error(err), .rx_full(rx_full));

   fifo #(.W(FIFO_W)) fifo_rx_unit
      (.clk(clk), .reset(reset), .rd(rd_uart),
       .wr(rx_done_tick), .w_data(rx_data_out),  
       .empty(rx_empty), .full(rx_full), .r_data(r_data));

   fifo #(.W(FIFO_W)) fifo_tx_unit
      (.clk(clk), .reset(reset), .rd(tx_done_tick), 
       .wr(wr_uart), .w_data(w_data), .empty(tx_empty),
       .full(tx_full), .r_data(tx_fifo_out));

   uart_tx uart_tx_unit
      (.clk(clk), .reset(reset), .tx_start(tx_fifo_not_empty), .dbit(databit), .sbit(stopbit),
       .s_tick(tick), .din(tx_fifo_out),
       .tx_done_tick(tx_done_tick), .tx(tx));

   assign tx_fifo_not_empty = ~tx_empty;
	
	assign databit = d_num == 1'b1 ? 4'b0111 : 4'b1000;
	assign stopbit = s_num == 1'b1 ? 6'b100000 : 6'b010000;
	
	
	
	assign baud = bd_rate == 2'b00 ? 12'b101000101100 : 	//1200 dvsr = 2604
					  bd_rate == 2'b01 ? 12'b010100010110 : 	//2400 dvsr = 1302
					  bd_rate == 2'b10 ? 12'b001010001011 : 	//4800 dvsr = 651
					  bd_rate == 2'b11 ? 12'b000101000110 :   //9600 dvsr = 326
												12'b000101000110; 	//default 9600 baud



endmodule