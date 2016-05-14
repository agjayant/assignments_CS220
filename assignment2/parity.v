module parity (
clock , // Clock input of the design
reset , // active high, synchronous Reset input
input_bit , //symbolises input bit stream 
output_bit // output parity of the input stream
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

// At each edge of the clock :- output is updated wrt the input_bit

always @ ( clock)
begin : PARITY // Block Name

  // At every edge of clock if reset is active, we set the output to 0

  if (reset == 1'b1) begin
	output_bit = 1'b0;
  end
  // if input_bit is one then output_bit toggles otherwise remains same
  else if (input_bit == 1'b1) begin : ADD
	  output_bit = output_bit + 1; 
  end
end // End of Block 

endmodule // End of Module parity

