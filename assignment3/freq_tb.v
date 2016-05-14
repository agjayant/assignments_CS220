`include "freq.v"
module freq_tb();

// Declare inputs as regs and outputs as wires
reg clock, reset, input_bit;
reg [23:0] input_stream; 
reg [4:0] index;
wire output_bit;

// Initialize all variables
initial begin
  $display ("time\t clk reset input_stream output_bit");
  $monitor ("%g\t %b   %b            %b       %b",
          $time, clock, reset, input_bit, output_bit);
  clock = 1;       // initial value of clock
  index = 0;
  input_stream = 24'b011011101111011111011110;
  reset = 1;    // Assert the reset
  #5 reset = 0;   // De-assert the reset
  #150 $finish;      // Terminate simulation
end

// Clock generator
always begin
  #5 clock = ~clock; // Toggle clock every 5 ticks
end


//relation between clock and input_bit 
//can be changed accordingly
always begin
  if( index == 23 ) begin
	  $finish;
  end 
  #5 index = index + 1;
  input_bit = input_stream[23-index];
end

// Connect module to test bench
freq initiate (
clock,
reset,
input_bit,
output_bit
);

endmodule
