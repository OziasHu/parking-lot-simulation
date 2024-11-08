//Xuanchang Hu
//03/13/2023
//EE 371
//Lab6 task2

//
`timescale 1 ps / 1 ps
module datapath (clk, reset, enter, exit, hours, num, maxCar, 
                 rushHour, endHour, noRush, noEnd);
   input logic clk, reset, enter, exit;
	input logic [2:0] hours;
	
	output logic [1:0] num;
	output logic [3:0] maxCar;
	output logic [2:0] rushHour, endHour;
	output logic noRush, noEnd;
	
	logic rush;
	
	assign noRush = ~rush;
	
	always_ff @(posedge clk) begin
           if (reset) begin
			        num <= 0;
                 maxCar <= 0;
           end else begin
			     if (enter && (num < 3)) begin
				     num <= num + 1;
					  maxCar <= maxCar + 1;
				  end
			     
				  if (exit && (num > 0)) begin
				     num <= num - 1;
			     end 	  
                 
				  	  
					  
				end	  
     end
	//
	
	always_ff @(posedge clk) begin
           if (reset) begin
					  rushHour <= 0;
					  endHour <= 0;
					  rush <= 0;
					  noEnd <= 1;
           end else begin
			     if ((rush == 0) && (num == 3)) begin
				     rush <= 1;
					  rushHour <= hours;
				  end
			     
				  if ((rush == 1) && (noEnd == 1) && (num == 0)) begin
				     noEnd <= 0;
				     endHour <= hours;
			     end 	  
             	  
				end	  
     end
	
endmodule

module datapath_testbench();
   logic clk, reset, enter, exit;
	logic [2:0] hours;
	
	logic [1:0] num;
	logic [3:0] maxCar;
	logic [2:0] rushHour, endHour;
	logic noRush, noEnd;
	
	logic rush;
   
	datapath dut1(.clk, .reset, .enter, .exit, .hours, .num, .maxCar, 
                 .rushHour, .endHour, .noRush, .noEnd);
	
	
   parameter clock_period = 100;
	  
	initial begin
	   clk <= 0;
		forever #(clock_period / 2) clk <= ~clk;
	end
     //
	  
	initial begin
	     reset <= 1;          @(posedge clk); 
		  reset <= 0;  enter <= 0; exit <= 0; hours <= 0; @(posedge clk);
		  hours <= 0; enter <= 1; exit <= 0;  @(posedge clk); // Hour 1
		  hours <= 0; enter <= 1; exit <= 0;  @(posedge clk); 
		  hours <= 0; enter <= 0; exit <= 0;  @(posedge clk);  
		  hours <= 1; enter <= 0; exit <= 0;  @(posedge clk); // Hour 2
		  hours <= 1; enter <= 0; exit <= 1;  @(posedge clk); 
		  hours <= 1; enter <= 1; exit <= 0;  @(posedge clk); 
		  hours <= 1; enter <= 0; exit <= 1;  @(posedge clk); 
		  hours <= 2; enter <= 0; exit <= 0;  @(posedge clk); // Hour 3 
		  hours <= 2; enter <= 1; exit <= 0;  @(posedge clk); 
		  hours <= 2; enter <= 1; exit <= 0;  @(posedge clk); 
		  hours <= 2; enter <= 1; exit <= 0;  @(posedge clk); 
		  hours <= 3; enter <= 0; exit <= 0;  @(posedge clk); // Hour 4  
		  hours <= 3; enter <= 0; exit <= 1;  @(posedge clk); 
		  hours <= 3; enter <= 0; exit <= 1;  @(posedge clk); 
		  hours <= 4; enter <= 0; exit <= 0;  @(posedge clk); // Hour 5 
		  hours <= 4; enter <= 1; exit <= 0;  @(posedge clk); 
		  hours <= 4; enter <= 0; exit <= 1;  @(posedge clk); 
		  hours <= 5; enter <= 0; exit <= 0;  @(posedge clk); // Hour 6 
		  hours <= 5; enter <= 1; exit <= 0;  @(posedge clk); 
		  hours <= 5; enter <= 1; exit <= 0;  @(posedge clk); 
		  hours <= 5; enter <= 0; exit <= 1;  @(posedge clk); 
		  hours <= 5; enter <= 1; exit <= 0;  @(posedge clk); 
		  hours <= 6; enter <= 0; exit <= 0;  @(posedge clk); // Hour 7 
		  hours <= 6; enter <= 0; exit <= 1;  @(posedge clk); 
		  hours <= 6; enter <= 0; exit <= 1;  @(posedge clk); 
		  hours <= 6; enter <= 0; exit <= 1;  @(posedge clk); 
		  hours <= 6; enter <= 0; exit <= 1;  @(posedge clk); 
		  hours <= 7; enter <= 0; exit <= 0;  @(posedge clk); // Hour 8 
		  hours <= 7; enter <= 1; exit <= 0;  @(posedge clk); 
		  hours <= 7; enter <= 1; exit <= 0;  @(posedge clk); 
		  hours <= 7; enter <= 0; exit <= 0;  @(posedge clk); // Hour display 
		  hours <= 7; enter <= 0; exit <= 0;  @(posedge clk);
		  hours <= 7; enter <= 0; exit <= 0;  @(posedge clk);
		  hours <= 7; enter <= 0; exit <= 0;  @(posedge clk);
		  reset <= 1; hours <= 0;             @(posedge clk); 
		  reset <= 0;                                @(posedge clk); 
		                                             @(posedge clk); 
	
	     $stop;
   end
	  

endmodule