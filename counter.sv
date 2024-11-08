//Xuanchang Hu
//03/13/2023
//EE 371
//Lab6 task2


// This moudle will cycle between 0 and 7
`timescale 1 ps / 1 ps
module counter(clk, reset, out);
	input logic clk, reset;
	output logic [2:0] out;
		
	always_ff @(posedge clk) begin
		if (reset) begin
			out <= 0;
		end else begin
			if (out < 7) begin
				out <= out + 1;
			end else begin // restart counter
				out <= 0;
			end
		end
	end
endmodule

module counter_testbench();
   logic clk, reset;
	logic [2:0] out;
   
	counter dut1(.clk, .reset, .out);
	
	
   parameter clock_period = 100;
	  
	initial begin
	   clk <= 0;
		forever #(clock_period / 2) clk <= ~clk;
	end
     //
	  
	initial begin
	     reset <= 1;          @(posedge clk); 
		  reset <= 0;          @(posedge clk);
		  @(posedge clk);
		  @(posedge clk);
		  @(posedge clk);
		  @(posedge clk);
		  @(posedge clk);
		  @(posedge clk);
		  @(posedge clk);
		  @(posedge clk);
		  @(posedge clk);
		  @(posedge clk);
		  reset <= 1;          @(posedge clk); 
		  reset <= 0;          @(posedge clk);
		  @(posedge clk);
	
	     $stop;
   end
	  

endmodule
