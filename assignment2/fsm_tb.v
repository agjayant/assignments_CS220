`include "fsm.v"
module fsm_tb();

// Declare inputs as regs and outputs as wires
reg clock, reset, input_bit;
wire [2:0] out_location;

// Initialize all variables
initial begin
  $display ("time\t clk reset input_bit location");
  $monitor ("%g\t %b   %b     %b       %b",
          $time, clock, reset, input_bit, out_location);
  clock = 1;       // initial value of clock
  reset = 0;       // initial value of reset
  #5 reset = 1;    // Assert the reset
  #10 reset = 0;   // De-assert the reset
  #100 $finish;      // Terminate simulation
end

// Clock generator
always begin
  #5 clock = ~clock; // Toggle clock every 5 ticks
end


//relation between clock and input_bit 
//can be changed accordingly
always begin
  #5 input_bit <= clock;
end

// Connect module to test bench
fsm initiate (
clock,
reset,
input_bit,
out_location
);

endmodule
