In this repository, we only cover task2

Lab Objectives 

In lab 1, you were tasked on creating a finite state machine to design a parking lot occupancy 
counter. Simple GPIO pins and a virtual breadboard were used to emulate the parking lot 
sensors. In the real world and in industry, you’ll find that your SystemVerilog designs will 
interface with complex sensors and scenarios to create larger systems. In this lab, we will reintroduce the parking lot occupancy, but instead of using simple breadboard components, 
we will be simulating an actual, 3D parking lot, while also integrating the concepts learned 
throughout the quarter.

Task 1: Parking Lot Breadboard
Take your implementation for lab 1, and demonstrate your functionality onto the new 
breadboard remote lab interface. You will need to change GPIO_0 reference to V_GPIO in your 
top-level module, as well as wire it to different GPIO pin numbers.
Note: The user interface for the breadboard and the FPGA input and output pins have changed. 
Please read “Updated GPIO Guide.pdf” available in the Files section on Canvas.
This task is graded on completion only.

Task 2: Parking Lot 3D Simulation
Consider the parking lot again with a single entry and exit gate. For simplicity, this parking lot 
can hold a maximum of 3 cars. One car can enter the parking lot, and one car can leave the 
parking lot at a time. The user will control when a car will arrive at the entrance gate through a 
button on the 3D simulation. When a car arrives, the rest of the functionality of the car is 
autonomous: the car will park at the parking spot of its choosing. Similarly, the user will control 
when a car will leave the parking lot. The entering or exiting car will wait at the entrance/exit 
gate until the gate opens, which is controllable by asserting the appropriate GPIO pin.
