//Xuanchang Hu
//03/13/2023
//EE 371
//Lab6 task2
`timescale 1 ps / 1 ps

// This module is the top level module of parking system. It takes CLOCK_50, HEX, KEY, SW as input.
// LEDR as output. And V_GPIO for both input and output. It can make the parking system open gate, count
// show the time, number of cars, rushHour, endHOur, RAM address and maximum number of cars on HEX. 
// It can also show whether the parking is full or not.
module DE1_SoC_task2 (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, SW, LEDR, V_GPIO);

	// define ports
	input  logic CLOCK_50;
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	input  logic [3:0] KEY;
	input  logic [9:0] SW;
	output logic [9:0] LEDR;
	inout  logic [35:23] V_GPIO;
   
	logic inP, outP, resetSW; // into parking, exit parking, reset switch
	logic [1:0] num; //Number
	logic full; //full
	logic inc; //increase
	

	assign resetSW = SW[9]; // reset switch is SW[9]
	

	// FPGA output
	assign V_GPIO[26] = V_GPIO[28];	// LED parking 1 && V_GPIO[28]
	assign V_GPIO[27] = V_GPIO[29];	// LED parking 2 && V_GPIO[29]
	assign V_GPIO[32] = V_GPIO[30];	// LED parking 3 && V_GPIO[30]
	assign V_GPIO[34] = V_GPIO[28] & V_GPIO[29] & V_GPIO[30];	// LED that show parking is full
	assign V_GPIO[31] = V_GPIO[23];	// Open entrance
	assign V_GPIO[33] = V_GPIO[24];	// Open exit

	// FPGA input
	assign LEDR[0] = V_GPIO[28];	// Presence parking 1
	assign LEDR[1] = V_GPIO[29];	// Presence parking 2
	assign LEDR[2] = V_GPIO[30];	// Presence parking 3
	assign LEDR[3] = V_GPIO[23];	// Presence entrance
	assign LEDR[4] = V_GPIO[24];	// Presence exit
	
	logic [31:0] div_clk;
	
	clock_divider clkdivide (.clock(CLOCK_50), .divided_clocks(div_clk));
	
	logic clk1, clk2;
	parameter whichClock = 26; // 0.75 Hz clock
	
	//assign clkSelect = CLOCK_50; // for simulation
	assign clk1 = div_clk[1]; // for enter clock
	assign clk2 = div_clk[24]; // for exit clock
	
	
	always_ff @(posedge clk1) begin
           if (V_GPIO[24] | LEDR[4] | V_GPIO[33]) begin
                 outP <= 1;
           end else
                 outP <= 0;
     end
	
	always_ff @(posedge clk2) begin
           if (V_GPIO[23] && V_GPIO[31] ) begin
                 inP <= 1;
           end else
                 inP <= 0;
     end
	
	// The main control of the program, it can receive enter, exit, and increase time operation orders.
	// And output HEX.
	control con(.clk(CLOCK_50), .reset(resetSW), .enter(inP), .exit(outP), .increaseTime(~KEY[0]),  
                .num, .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3), .HEX4(HEX4), .HEX5(HEX5), .full(full));


endmodule  // DE1_SoC


// It tests cases of enter, exit cars. I also tests the case when parking is full and reset parking.
// HEX5 shows the hours during 8 hour work time. When thr number of cars are 3, HEX3 to 0 shows FULL. 
// Otherwise, HEX0 shows the number of cars. After the end of work day, the HEX3 to 2 will shows 
// the rushhour and endHour. HEX1 will show the address(Hour) and HEX0 will show the maximum cars.
module DE1_SoC_task2_testbench();
   logic CLOCK_50;
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [3:0] KEY;
	logic [9:0] SW;
	logic [9:0] LEDR;
	wire [35:23] V_GPIO;
	
	logic enter, exit, reset;
	logic [1:0] num;
	logic full;
	logic increaseTime;
	
	assign KEY[0] = ~increaseTime;
	assign SW[9] = reset;
	assign V_GPIO[23] = enter;	// Presence entrance && enter
	assign V_GPIO[24] = exit;	// Presence exit && exit
	
	DE1_SoC_task2 dut1(.CLOCK_50, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .SW, .LEDR, .V_GPIO);
	
	parameter clock_period = 100;
	  
	  initial begin
	     CLOCK_50 <= 0;
		  forever #(clock_period / 2) CLOCK_50 <= ~CLOCK_50;
	  end
     //
	  
	  initial begin
	     reset <= 1;          @(posedge CLOCK_50); 
		  reset <= 0; increaseTime <= 0; enter <= 0; exit <= 0;  @(posedge CLOCK_50);
		  increaseTime <= 0; enter <= 1; exit <= 0;  @(posedge CLOCK_50); // Hour 1
		  increaseTime <= 0; enter <= 1; exit <= 0;  @(posedge CLOCK_50); 
		  increaseTime <= 0; enter <= 0; exit <= 0;  @(posedge CLOCK_50); 
		  increaseTime <= 1; enter <= 0; exit <= 0;  @(posedge CLOCK_50); // Hour 2
		  increaseTime <= 0; enter <= 0; exit <= 1;  @(posedge CLOCK_50); 
		  increaseTime <= 0; enter <= 1; exit <= 0;  @(posedge CLOCK_50); 
		  increaseTime <= 0; enter <= 0; exit <= 1;  @(posedge CLOCK_50); 
		  increaseTime <= 0; enter <= 0; exit <= 0;  @(posedge CLOCK_50);
		  increaseTime <= 1; enter <= 0; exit <= 0;  @(posedge CLOCK_50); // Hour 3 
		  increaseTime <= 0; enter <= 1; exit <= 0;  @(posedge CLOCK_50); 
		  increaseTime <= 0; enter <= 1; exit <= 0;  @(posedge CLOCK_50); 
		  increaseTime <= 0; enter <= 1; exit <= 0;  @(posedge CLOCK_50); 
		  increaseTime <= 0; enter <= 0; exit <= 0;  @(posedge CLOCK_50); 
		  increaseTime <= 1; enter <= 0; exit <= 0;  @(posedge CLOCK_50); // Hour 4  
		  increaseTime <= 0; enter <= 0; exit <= 1;  @(posedge CLOCK_50); 
		  increaseTime <= 0; enter <= 0; exit <= 1;  @(posedge CLOCK_50); 
		  increaseTime <= 1; enter <= 0; exit <= 0;  @(posedge CLOCK_50); // Hour 5 
		  increaseTime <= 0; enter <= 1; exit <= 0;  @(posedge CLOCK_50); 
		  increaseTime <= 0; enter <= 0; exit <= 1;  @(posedge CLOCK_50); 
		  increaseTime <= 1; enter <= 0; exit <= 0;  @(posedge CLOCK_50); // Hour 6 
		  increaseTime <= 0; enter <= 1; exit <= 0;  @(posedge CLOCK_50); 
		  increaseTime <= 0; enter <= 1; exit <= 0;  @(posedge CLOCK_50); 
		  increaseTime <= 0; enter <= 0; exit <= 1;  @(posedge CLOCK_50); 
		  increaseTime <= 0; enter <= 1; exit <= 0;  @(posedge CLOCK_50); 
		  increaseTime <= 1; enter <= 0; exit <= 0;  @(posedge CLOCK_50); // Hour 7 
		  increaseTime <= 0; enter <= 0; exit <= 1;  @(posedge CLOCK_50); 
		  increaseTime <= 0; enter <= 0; exit <= 1;  @(posedge CLOCK_50); 
		  increaseTime <= 0; enter <= 0; exit <= 1;  @(posedge CLOCK_50); 
		  increaseTime <= 0; enter <= 0; exit <= 1;  @(posedge CLOCK_50); 
		  increaseTime <= 1; enter <= 0; exit <= 0;  @(posedge CLOCK_50); // Hour 8 
		  increaseTime <= 0; enter <= 1; exit <= 0;  @(posedge CLOCK_50); 
		  increaseTime <= 0; enter <= 1; exit <= 0;  @(posedge CLOCK_50); 
		  increaseTime <= 1; enter <= 0; exit <= 0;  @(posedge CLOCK_50); // Hour display 
		  increaseTime <= 0; enter <= 0; exit <= 0;  @(posedge CLOCK_50);
		  increaseTime <= 0; enter <= 0; exit <= 0;  @(posedge CLOCK_50);
		  increaseTime <= 0; enter <= 0; exit <= 0;  @(posedge CLOCK_50);
		  reset <= 1;                                @(posedge CLOCK_50); 
		  reset <= 0;                                @(posedge CLOCK_50); 
		                                             @(posedge CLOCK_50); 
		  
	     $stop;
     end


endmodule

