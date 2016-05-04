module fsm (
clock , // Clock input of the design
reset , // active high, synchronous Reset input
input_bit , //symbolises input bit stream 
out_location // output location wrt to the input and previous location
); // End of port list


//-------------Input Ports-----------------------------
input clock ;
input reset ;
input input_bit ;


//-------------Output Ports----------------------------
output [2:0] out_location ;

//-------------Input ports Data Type-------------------
wire clock ;
wire reset ;
wire input_bit ;

//-------------Output Ports Data Type------------------
reg [2:0] out_location ;

// At each edge of the clock :- output is updated wrt the input_bit

always @ ( clock)
begin : LOCATION // Block Name

  // At every edge of clock if reset is active, we set the out_location to CC

  if (reset == 1'b1) begin
        out_location = 3'b000;
  end  // out_location changes wrt input and previous location
  else begin
	if(out_location == 3'b000) begin 
		if (input_bit == 1'b1) begin
			out_location = 3'b001;
		end
	end
	else if (out_location == 3'b001 ) begin
		if (input_bit == 1'b0) begin
			out_location = 3'b010;
		end
		else begin
			out_location = 3'b100;
		end
	end
	else if (out_location == 3'b010 ) begin 
		if (input_bit == 1'b0) begin
			out_location = 3'b011;
		end
		else begin
			out_location = 3'b100;
		end
	end
	else if (out_location == 3'b011 ) begin 
		if (input_bit == 1'b1) begin
			out_location = 3'b000;
		end
	end
	else if (out_location == 3'b100 ) begin
		if (input_bit == 1'b0) begin
			out_location = 3'b111;
		end
		else begin
			out_location = 3'b101;
		end
	end
	else if (out_location == 3'b101 ) begin
		if (input_bit == 1'b0) begin
			out_location = 3'b011;
		end
		else begin
			out_location = 3'b110;
		end
	end
	else if (out_location == 3'b110 ) begin 
		if (input_bit == 1'b0) begin
			out_location = 3'b111;
		end
	end
	else if (out_location == 3'b111 ) begin 
		if (input_bit == 1'b0) begin
			out_location = 3'b001;
		end
		else begin
			out_location = 3'b101;
		end
	end
  end //END of location changer
end // End of Block 

endmodule // End of Module
