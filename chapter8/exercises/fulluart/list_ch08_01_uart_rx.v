//Listing 8.1
module uart_rx
   #(
     //parameter //DBIT = 8,     // # data bits
               //SB_TICK = 16  // # ticks for stop bits
   )
   (
    input wire clk, reset,
    input wire rx, s_tick, rx_full,
	 input wire [3:0] dbit,
	 input wire [5:0] sbit,
	 input wire [1:0] par,
    output reg rx_done_tick,
    output wire [7:0] dout,
	 output wire [2:0] rx_error
   );

   // symbolic state declaration
   localparam [2:0]
      idle  = 3'b000,
      start = 3'b001,
      data  = 3'b010,
      stop  = 3'b011,
		parity = 3'b100;
		
	//parity 
	localparam [1:0]
		none = 2'b00,
		even = 2'b01,
		odd  = 2'b10;
	
	//error
	localparam [2:0]
		err_parity = 3'b001,
		err_frame  = 3'b010,
		err_data   = 3'b100;

   // signal declaration
   reg [2:0] state_reg, state_next;
   reg [4:0] s_reg, s_next;
   reg [2:0] n_reg, n_next;
   reg [7:0] b_reg, b_next;
	reg [2:0] err_flag;

   // body
   // FSMD state & data registers
   always @(posedge clk, posedge reset)
      if (reset)
         begin
            state_reg <= idle;
            s_reg <= 0;
            n_reg <= 0;
            b_reg <= 0;
				
         end
      else
         begin
            state_reg <= state_next;
            s_reg <= s_next;
            n_reg <= n_next;
            b_reg <= b_next;
         end

   // FSMD next-state logic
   always @*
   begin
      state_next = state_reg;
      rx_done_tick = 1'b0;
		err_flag = 3'b000;
      s_next = s_reg;
      n_next = n_reg;
      b_next = b_reg;
      case (state_reg)
         idle:
            if (~rx)
               begin
                  state_next = start;
                  s_next = 0;
               end
         start:
            if (s_tick)
               if (s_reg==7)
                  begin
                     state_next = data;
                     s_next = 0;
                     n_next = 0;
                  end
               else
                  s_next = s_reg + 1;
         data:
            if (s_tick)
               if (s_reg==15)
                  begin
                     s_next = 0;
                     b_next = {rx, b_reg[7:1]};
							
                     if (n_reg==(dbit-1))
								if(par != none)
									state_next = parity;
								else
									state_next = stop ;
                      else
                        n_next = n_reg + 1;
                   end
               else
                  s_next = s_reg + 1;
			parity:
				if (s_tick)
               if (s_reg==15)
                  begin
                     //parity check
							if(par == odd)
								begin
								if(rx != ~(^b_reg))
									err_flag = err_parity; //parity mismatch error
								end
							else if(par == even)
								begin
								if(rx != ^b_reg) //xor the received data to get the parity bit
									err_flag = err_parity; //parity mismatch error
								end
								
							state_next = stop;
                   end
               else
                  s_next = s_reg + 1;
         stop:
            if (s_tick)
               if (s_reg==(sbit-1))
                  begin
							if(~rx)
								err_flag = err_frame; //framing error
							
							if(rx_full)
								err_flag = err_data; //buffer overrun error		
								
                     state_next = idle;
                     rx_done_tick =1'b1;
							
                  end
               else
                  s_next = s_reg + 1;
      endcase
   end
   // output
   assign dout = b_reg;
	assign rx_error = err_flag;

endmodule