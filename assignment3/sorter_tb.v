`include "sorter.v"
module sorter_tb();

// Declare inputs as regs and outputs as wires
reg clock, reset;
reg [11:0] input_weight;
reg [11:0] weights [0:5]; 
reg [2:0] i;  //for iteration
wire [7:0] out_cnt [0:5];
wire [2:0] cur_grp;

// Initialize all variables
initial begin
  $display ("time\t clk reset input_weight cur_grp grp1 grp2 grp3 grp4 grp5 grp6");
  $monitor ("%g\t %b   %b     	   %d     %d  %d  %d  %d  %d  %d  %d",
          $time, clock, reset, input_weight, cur_grp, out_cnt[0],out_cnt[1],out_cnt[2],out_cnt[3],out_cnt[4],out_cnt[5] );
  clock = 1;       // initial value of clock
  reset = 1;    // Assert the reset
  i=0;

  //setting the input
  weights[0] = 250 ; weights[1]=0; weights[2]=300; weights[3]=0; weights[4] =501; weights[5]=512;

  #10 reset = 0;   // De-assert the reset
  #150 $finish;      // Terminate simulation
end

// Clock generator
always begin
  #5 clock = ~clock; // Toggle clock every 5 ticks
end


//relation between clock and input_weight 
//can be changed accordingly
always begin
	#10 input_weight = weights[i];
	i= i+1;

	//terminating on end of input	
	if (i == 6 ) begin
		#5 $finish;
	end
end

// Connect module to test bench
sorter initiate (
clock,
reset,
input_weight,
//grp1,grp2,grp3,grp4,grp5,grp6,
out_cnt[0],out_cnt[1],out_cnt[2],out_cnt[3],out_cnt[4],out_cnt[5],
cur_grp
);

endmodule
