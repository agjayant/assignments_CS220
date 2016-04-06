`include "4_bit_adder.v"

module four_bit_adder_tb();
//inputs : reg
reg [3:0] A,B;

//outputs : wire
wire [3:0] S;
wire Cout;

initial begin
$display ("time\t A\t B\t S\t C_out");
  $monitor ("%g\t %b   %b     %b      %b",
          $time, A, B, S, Cout);        //to monitor inputs and outputs

A = 4'b0000;     //initialising inputs
B = 4'b0000;
#160 $finish;     //time for sufficient number of test cases
end

always begin
	#5 A=A + 4'b0001;    //updating inputs for different test cases
	#5 B=B + 4'b0001;
end


four_bit_adder initiate (          //instance of the adder
A,
B,
S,
Cout
);


endmodule
