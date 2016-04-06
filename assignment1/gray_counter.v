module gray_counter (
clock , // Clock input of the design
reset , // active high, synchronous Reset input
enable , // Active high enable signal for counter
gray // 4 bit vector output of the counter
); // End of port list


//-------------Input Ports-----------------------------
input clock ;
input reset ;
input enable ;


//-------------Output Ports----------------------------
output [3:0] gray ;

//-------------Input ports Data Type-------------------
wire clock ;
wire reset ;
wire enable ;

//-------------Output Ports Data Type------------------
reg [3:0] gray ;

reg [3:0] counter ;

// Since this counter is a positive edge trigged one,
// We trigger the below block with respect to positive
// edge of the clock.

always @ ( clock)
begin : GRAY_CODE // Block Name
  // At every rising edge of clock we check if reset is active
  // If active, we load the counter and gray code with 4'b0000
  if (reset == 1'b1) begin
    counter <=  4'b0000;
    gray <= 4'b0000;
  end
  // If enable is active, then we increment the counter
  else if (enable == 1'b1) begin
    counter <= counter + 1;
    assign gray = { counter[3] , counter[3]^counter[2] , counter[2]^counter[1] , counter[1]^counter[0] }; //assigning gray code from binary counter
  end
end // End of Block COUNTER

endmodule // End of Module counter

