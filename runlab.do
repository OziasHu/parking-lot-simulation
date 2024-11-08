# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./ram8x16.v"
vlog "./DE1_SoC_task2.sv"
vlog "./counter.sv"
vlog "./fsm.sv"
vlog "./datapath.sv"
vlog "./display.sv"
vlog "./control.sv"
vlog "./clock_divider.sv"
vlog "./DE1_SoC_task2.sv"


# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
#vsim -voptargs="+acc" -t 1ps -lib work clock_divider_testbench -Lf altera_mf_ver
#vsim -voptargs="+acc" -t 1ps -lib work display_testbench -Lf altera_mf_ver
vsim -voptargs="+acc" -t 1ps -lib work control_testbench -Lf altera_mf_ver
#vsim -voptargs="+acc" -t 1ps -lib work fsm_testbench -Lf altera_mf_ver
#vsim -voptargs="+acc" -t 1ps -lib work counter_testbench -Lf altera_mf_ver
#vsim -voptargs="+acc" -t 1ps -lib work datapath_testbench -Lf altera_mf_ver
#vsim -voptargs="+acc" -t 1ps -lib work DE1_SoC_task2_testbench -Lf altera_mf_ver

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
# do clock_divider_wave.do
#do display_wave.do
do control_wave.do
#do fsm_wave.do
#do counter_wave.do
#do datapath_wave.do
#do DE1_SoC_task2_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
