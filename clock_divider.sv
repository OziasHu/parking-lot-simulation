// Xuanchang Hu
// 01/20/2023
// EE 371
// Lab6 Task 2

// divided_clocks[0] = 25MHz, [1] = 12.5Mhz, ... [23] = 3Hz, [24] = 1.5Hz, [25] = 0.75Hz, ... 
// It takes clock as input and divided_clocks as output. it can divide clock into 
// different frequency.
module clock_divider(clock, divided_clocks); 
   input logic clock; 
   output logic [31:0] divided_clocks = 0; 
 
   always_ff @(posedge clock) begin 
      divided_clocks <= divided_clocks + 1; 
   end 
 
endmodule

module clock_divider_testbench(); 
   logic clock; 
   logic [31:0] divided_clocks;
   
	`timescale 1 ps / 1 ps
	
   clock_divider dut(.clock, .divided_clocks);
	
	initial begin
	   @(posedge clock);
		@(posedge clock);
	
	end
	
	
 
endmodule
