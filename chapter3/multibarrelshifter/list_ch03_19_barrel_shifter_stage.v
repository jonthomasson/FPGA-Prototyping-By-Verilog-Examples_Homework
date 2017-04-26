// Listing 3.19
module barrel_shifter_stage
   (
    input wire [7:0] a,
    input wire [2:0] amt,
	 input wire lr,
    output reg [7:0] y
   );

   // signal declaration
   reg [7:0] s0, s1;


	
	always @*
	begin
		if(lr)
			begin //shift left
				// body
				// stage 0, shift 0 or 1 bit
				 s0 = amt[0] ? {a[6:0], a[7]} : a;
				// stage 1, shift 0 or 2 bits
				 s1 = amt[1] ? {a[5:0], a[7:6]} : s0;
				// stage 2, shift 0 or 4 bits
				 y = amt[2] ? {a[3:0], a[7:4]} : s1;	
			end
		else
			begin //shift right
				// body
				// stage 0, shift 0 or 1 bit
				 s0 = amt[0] ? {a[0], a[7:1]} : a;
				// stage 1, shift 0 or 2 bits
				 s1 = amt[1] ? {s0[1:0], s0[7:2]} : s0;
				// stage 2, shift 0 or 4 bits
				 y = amt[2] ? {s1[3:0], s1[7:4]} : s1;
			end
	end

endmodule