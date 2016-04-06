`include "gray_counter.v"
module gray_counter_tb();
// Declare inputs as regs and outputs as wires
reg clock, reset, enable;
wire [3:0] gray;

// Initialize all variables
initial begin
  $display ("time\t clk reset enable gray");
  $monitor ("%g\t %b   %b     %b    %b",
          $time, clock, reset, enable, gray);
  clock = 1;       // initial value of clock
  reset = 0;       // initial value of reset
  enable = 0;      // initial value of enable
  #5 reset = 1;    // Assert the reset
  #10 reset = 0;   // De-assert the reset
  #10 enable = 1;  // Assert enable
  #100 enable = 0; // De-assert enable //time set to get all the required range of the gray counter
  #5 $finish;      // Terminate simulation
end

// Clock generator
always begin
  #5 clock = ~clock; // Toggle clock every 5 ticks
end

always begin
	#3
	if( gray == 4'b1000 )
	begin
		$display ("T-UP");
		$finish;
	end
end

// Connect DUT to test bench
gray_counter initiate (
clock,
reset,
enable,
gray
);

endmodule
