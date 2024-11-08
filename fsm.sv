//Xuanchang Hu
//03/13/2023
//EE 371
//Lab6 task2

// fsm implement 
`timescale 1 ps / 1 ps
module fsm(clk, reset, enter, exit, increaseTime, hours, endDay);
     input logic clk, reset, enter, exit, increaseTime;
     
     
	  output logic [2:0] hours;
	  output logic endDay;
	  
  // Setting 8 states to track cars at each hour
     enum {none, s1, s2, s3, s4, s5, s6, s7, s8, sDisplay} ps, ns;
	  
	  always_comb begin
	     case (ps)
		     none: begin
			        hours = 0;
					  endDay = 0;
					  ns = s1;
					  end
		     
		     
		     s1: begin
			      hours = 0;
					endDay = 0;
			      if (increaseTime) 
					   ns = s2;
					else
				      ns = s1;	
					end
			  
		     s2: begin
			      hours = 1;
					endDay = 0;
			      if (increaseTime) 
					   ns = s3;
					else
				      ns = s2;	
					
					end
					
			  s3: begin
			      hours = 2;
					endDay = 0;
			      if (increaseTime) 
					   ns = s4;	
					else
				      ns = s3;		
					end
			  
			  s4: begin
			      hours = 3;
					endDay = 0;
			      if (increaseTime) 
					   ns = s5;
					else
				      ns = s4;	
					end
			  
			  s5: begin
			      hours = 4;
					endDay = 0;
			      if (increaseTime) 
					   ns = s6;
					else
				      ns = s5;	
					end
						
			  s6: begin
			      hours = 5;
					endDay = 0;
			      if (increaseTime) 
					   ns = s7;
					else
				      ns = s6;	
				   end	
			    
		     s7: begin
			      hours = 6;
					endDay = 0;
			      if (increaseTime) 
					   ns = s8;
					else
				      ns = s7;	
				   end	
					
			  s8: begin
			      hours = 7;
					endDay = 0;
			      if (increaseTime) 
					   ns = sDisplay;
					else
				      ns = s8;	
				   end		
		     
			  sDisplay: begin
			      hours = 7;
					endDay = 1;
			      if (increaseTime) 
					   ns = s1;
					else
				      ns = sDisplay;	
				   end	
		  
		  endcase
		  
		  
		  
	  end  
	  
	  
	  //After reset, it returns to none state, otherwise, it goes to ns
     always_ff @(posedge clk) begin
           if (reset) begin
                 ps <= none;
           end else
                 ps <= ns;
     end


endmodule

module fsm_testbench();
   logic clk, reset, enter, exit, increaseTime;
     
     
	logic [2:0] hours;
	logic endDay;
   
	fsm dut1(.clk, .reset, .enter, .exit, .increaseTime, .hours, .endDay);
	
	
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
		                                             @(posedge clk); 
		  increaseTime <= 1; enter <= 0; exit <= 0;  @(posedge clk); // Hour 2
		  increaseTime <= 0; enter <= 0; exit <= 1;  @(posedge clk); 
		  increaseTime <= 0; enter <= 1; exit <= 0;  @(posedge clk); 
		  increaseTime <= 0; enter <= 0; exit <= 1;  @(posedge clk); 
		  increaseTime <= 1; enter <= 0; exit <= 0;  @(posedge clk); // Hour 3 
		  increaseTime <= 0; enter <= 1; exit <= 0;  @(posedge clk); 
		  increaseTime <= 0; enter <= 1; exit <= 0;  @(posedge clk); 
		  increaseTime <= 0; enter <= 1; exit <= 0;  @(posedge clk); 
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
