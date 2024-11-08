// Xuanchang Hu, Ethan Ma
// 01/20/2023
// EE 371
// Lab6 Task 2

// display can display the number on the 6 HEX displays. It takes address as
// input and hex as output. 
`timescale 1 ps / 1 ps
module display(address, hex);
 input  logic [3:0] address;
 output logic [6:0] hex;

 always_comb begin
  case (address)
  
   0: hex = 7'b1000000;
   1: hex = 7'b1111001;
   2: hex = 7'b0100100;
   3: hex = 7'b0110000;
   4: hex = 7'b0011001;
   5: hex = 7'b0010010;
   6: hex = 7'b0000010;
   7: hex = 7'b1111000;
   8: hex = 7'b0000000;
   9: hex = 7'b0010000;
   10: hex = 7'b0001000; //A
   11: hex = 7'b0000011; //b
   12: hex = 7'b1000110; //C
   13: hex = 7'b0100001; //d 
   14: hex = 7'b0000110; //E
   15: hex = 7'b0001110; //F
      endcase
 end 
  
endmodule  

// display_testbench tests all cases of number
module display_testbench();
   logic [3:0] address;
   logic [6:0] hex; 
	
	
	display dut(.address, .hex);
	
	initial begin
	   address = 4'b0100;   #10; //4
	   address = 4'b0001;   #10; //1
		address = 4'b0010;   #10; //2
		address = 4'b0011;   #10; //3
		address = 4'b0101;   #10; //5
		address = 4'b0110;   #10; //6
		address = 4'b0111;   #10; //7
		address = 4'b1000;   #10; //8
		address = 4'b1001;   #10; //9
		address = 4'b1010;   #10; //10
		$stop();
	end
	
endmodule
