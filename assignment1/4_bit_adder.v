module four_bit_adder( A , B , S , Cout );

input [3:0] A,B;
output [3:0] S;
output Cout;

// inputs : wire
wire [3:0] A,B;

//outut : reg
reg [3:0] S;
reg Cout;

//checing for change in input
always @( A or B )
begin : ADD
	{Cout, S} = A + B ; 
end

endmodule //end of module
