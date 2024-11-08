//Xuanchang Hu
//03/13/2023
//EE 371
//Lab6 task2

// This module is to control the parking counter
`timescale 1 ps / 1 ps
module control (clk, reset, enter, exit, increaseTime,  
                num, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, full);
   
	input logic clk, reset, enter, exit, increaseTime;

   output logic [1:0] num;
   output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;	
	output logic full;
					  
	logic [2:0] hours;
	logic [3:0] maxCar;
	logic [2:0] rushHour, endHour;
	logic [2:0] out;
	logic endDay;
	
	logic [3:0] maxOut;
	logic [6:0] cars, dayTime, outNum, carNum, rushTime, endTime;
	logic noRush, noEnd;
	
	assign full = (num == 3);
	
	// Clock divider setup
	logic [31:0] div_clk;
	
	clock_divider clkdivide (.clock(clk), .divided_clocks(div_clk));
	
	logic clkSelect;
	parameter whichClock = 25; // 0.75 Hz clock
	
	assign clkSelect = clk; // for simulation
	//assign clkSelect = div_clk[whichClock]; // for board
	
	
	
	// finite state machines, it can output hours to show time
	fsm statemachine(.clk(clkSelect), .reset, .enter, .exit, .increaseTime, .hours, .endDay);
	
	
	// datapath can output number of cars in parking, also output rush hour, end of rush hour.
	datapath data(.clk(clkSelect), .reset, .enter, .exit, .hours, .num, .maxCar, .rushHour, .endHour,
	               .noRush, .noEnd);
	
	
	// counter that cycle between 0-7
	counter cycle(.clk(clkSelect), .reset, .out);
	
	// It can stores the max value of cars at each hour
	ram8x16 ram(.clock(clkSelect), .data(maxCar), .rdaddress(out), .wraddress(hours), .wren(1'b1), .q(maxOut));
	
	
	display h5(.address({1'b0, hours}), .hex(dayTime)); // HEX that show daytime
	display ca(.address({2'b0, num}), .hex(cars));      // HEX that show number of cars
	display rushTim(.address({1'b0, rushHour}), .hex(rushTime)); // HEX that show rush time
	display endTim(.address({1'b0, endHour}), .hex(endTime)); // HEX that show end of rush time
	display outNu(.address({1'b0, out}), .hex(outNum)); // HEX that show address counter number
	display carNu(.address(maxOut), .hex(carNum)); // HEX that show max number of cars in ram
	
	always_comb begin
	   if (endDay == 0) begin //If day not end
		   if (num == 3) begin
			   HEX5 = dayTime;
            HEX4 = 7'b1111111; //blank
            HEX3 = 7'b0001110; // F
            HEX2 = 7'b1000001; // U
            HEX1 = 7'b1000111; // L
            HEX0 = 7'b1000111; // L
			end else begin
			   HEX5 = dayTime;
				HEX4 = 7'b1111111;
				HEX3 = 7'b1111111;
				HEX2 = 7'b1111111;
				HEX1 = 7'b1111111;
				HEX0 = cars;
			end 
	   end else begin         //If day ends
		   if (noRush) begin
			   HEX4 = 7'b0111111;
			end else begin
		      HEX4 = rushTime;
			end 
			
		   if (noEnd) begin
			   HEX3 = 7'b0111111;
			end else begin
		      HEX3 = endTime;
			end 
			
			HEX2 = outNum;
			HEX1 = carNum;
			HEX5 = 7'b1111111;
			HEX0 = 7'b1111111;
		end
		
		
//		      HEX5 = 7'b1111111;
//				HEX4 = 7'b1111111;
//				HEX3 = 7'b1111111;
//				HEX2 = 7'b1111111;
//				HEX1 = 7'b1111111;
//				HEX0 = 7'b1111111;
   end
	//	      	
				
	
	
	
	
endmodule	
   
module control_testbench();
   logic clk, reset, enter, exit, increaseTime;

   logic [1:0] num;
   logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;	
	logic full;
	
   //just logics	
	logic [2:0] hours;
	logic [6:0] maxCar;
	logic [2:0] rushHour, endHour;
	logic [2:0] out;
	logic endDay;
	
	logic [3:0] maxOut;
	logic [6:0] cars, dayTime, outNum, carNum, rushTime, endTime;
	logic noRush, noEnd;
	
	control dut1(.clk, .reset, .enter, .exit, .increaseTime,  
                .num, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .full);

    parameter clock_period = 100;
	  
	  initial begin
	     clk <= 0;
		  forever #(clock_period / 2) clk <= ~clk;
	  end
     //
	  
	  initial begin
	     reset <= 1;          @(posedge clk); 
		  reset <= 0; increaseTime <= 0; enter <= 0; exit <= 0;  @(posedge clk);
		  increaseTime <= 0; enter <= 1; exit <= 0;  @(posedge clk); // Hour 1
		  increaseTime <= 0; enter <= 1; exit <= 0;  @(posedge clk); 
		  increaseTime <= 0; enter <= 0; exit <= 0;  @(posedge clk); 
		  increaseTime <= 1; enter <= 0; exit <= 0;  @(posedge clk); // Hour 2
		  increaseTime <= 0; enter <= 0; exit <= 1;  @(posedge clk); 
		  increaseTime <= 0; enter <= 1; exit <= 0;  @(posedge clk); 
		  increaseTime <= 0; enter <= 0; exit <= 1;  @(posedge clk); 
		  increaseTime <= 0; enter <= 0; exit <= 0;  @(posedge clk);
		  increaseTime <= 1; enter <= 0; exit <= 0;  @(posedge clk); // Hour 3 
		  increaseTime <= 0; enter <= 1; exit <= 0;  @(posedge clk); 
		  increaseTime <= 0; enter <= 1; exit <= 0;  @(posedge clk); 
		  increaseTime <= 0; enter <= 1; exit <= 0;  @(posedge clk); 
		  increaseTime <= 0; enter <= 0; exit <= 0;  @(posedge clk); 
		  increaseTime <= 1; enter <= 0; exit <= 0;  @(posedge clk); // Hour 4  
		  increaseTime <= 0; enter <= 0; exit <= 1;  @(posedge clk); 
		  increaseTime <= 0; enter <= 0; exit <= 1;  @(posedge clk); 
		  increaseTime <= 1; enter <= 0; exit <= 0;  @(posedge clk); // Hour 5 
		  increaseTime <= 0; enter <= 1; exit <= 0;  @(posedge clk); 
		  increaseTime <= 0; enter <= 0; exit <= 1;  @(posedge clk); 
		  increaseTime <= 1; enter <= 0; exit <= 0;  @(posedge clk); // Hour 6 
		  increaseTime <= 0; enter <= 1; exit <= 0;  @(posedge clk); 
		  increaseTime <= 0; enter <= 1; exit <= 0;  @(posedge clk); 
		  increaseTime <= 0; enter <= 0; exit <= 1;  @(posedge clk); 
		  increaseTime <= 0; enter <= 1; exit <= 0;  @(posedge clk); 
		  increaseTime <= 1; enter <= 0; exit <= 0;  @(posedge clk); // Hour 7 
		  increaseTime <= 0; enter <= 0; exit <= 1;  @(posedge clk); 
		  increaseTime <= 0; enter <= 0; exit <= 1;  @(posedge clk); 
		  increaseTime <= 0; enter <= 0; exit <= 1;  @(posedge clk); 
		  increaseTime <= 0; enter <= 0; exit <= 1;  @(posedge clk); 
		  increaseTime <= 1; enter <= 0; exit <= 0;  @(posedge clk); // Hour 8 
		  increaseTime <= 0; enter <= 1; exit <= 0;  @(posedge clk); 
		  increaseTime <= 0; enter <= 1; exit <= 0;  @(posedge clk); 
		  increaseTime <= 1; enter <= 0; exit <= 0;  @(posedge clk); // Hour display 
		  increaseTime <= 0; enter <= 0; exit <= 0;  @(posedge clk);
		  increaseTime <= 0; enter <= 0; exit <= 0;  @(posedge clk);
		  increaseTime <= 0; enter <= 0; exit <= 0;  @(posedge clk);
		  reset <= 1;                                @(posedge clk); 
		  reset <= 0;                                @(posedge clk); 
		                                             @(posedge clk); 
		  
	     $stop;
     end
	  

endmodule
   

