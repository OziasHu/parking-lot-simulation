onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /DE1_SoC_task2_testbench/clock_period
add wave -noupdate /DE1_SoC_task2_testbench/CLOCK_50
add wave -noupdate /DE1_SoC_task2_testbench/HEX5
add wave -noupdate /DE1_SoC_task2_testbench/HEX4
add wave -noupdate /DE1_SoC_task2_testbench/HEX3
add wave -noupdate /DE1_SoC_task2_testbench/HEX2
add wave -noupdate /DE1_SoC_task2_testbench/HEX1
add wave -noupdate /DE1_SoC_task2_testbench/HEX0
add wave -noupdate /DE1_SoC_task2_testbench/increaseTime
add wave -noupdate /DE1_SoC_task2_testbench/enter
add wave -noupdate /DE1_SoC_task2_testbench/exit
add wave -noupdate /DE1_SoC_task2_testbench/reset
add wave -noupdate {/DE1_SoC_task2_testbench/SW[9]}
add wave -noupdate {/DE1_SoC_task2_testbench/KEY[0]}
add wave -noupdate -radix unsigned /DE1_SoC_task2_testbench/dut1/num
add wave -noupdate /DE1_SoC_task2_testbench/dut1/full
add wave -noupdate /DE1_SoC_task2_testbench/V_GPIO
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3385 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 85
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {4195 ps}
