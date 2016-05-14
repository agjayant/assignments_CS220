module freq (
clock , // Clock input
reset , // active high, synchronous Reset input
input_bit , //symbolises input bit stream 
output_bit // output 
); // End of port list


//-------------Input Ports-----------------------------
input clock ;
input reset ;
input input_bit ;


//-------------Output Ports----------------------------
output output_bit ;

//-------------Input ports Data Type-------------------
wire clock ;
wire reset ;
wire input_bit ;

//-------------Output Ports Data Type------------------
reg output_bit ;

//-------------Variables Used--------------------------
reg [2:0] count ;

// At each edge of the clock :- output is updated wrt count

always @ ( clock)
begin : FREQ // Block Name

  // At every edge of clock if reset is active, we set the output to 0

  if (reset == 1'b1) begin
        output_bit <= 1'b0;
	count <= 0 ;
  end 
  // if input_bit is one then count is updated
  else if (input_bit == 1'b1) begin
	count <= count + 1 ;
	output_bit <= 1'b0;
  end  // if input_bit is zero then count is set to 0  // if count is 2 or 4 output_bit is updated to 1
  else begin
	  if (count == 2 || count == 4  ) begin
		  output_bit <= 1'b1;
	  end
	  else begin
		  output_bit <= 1'b0;
          end
	  count <= 0 ;
  end 
end // End of Block 

endmodule // End of Module parity

