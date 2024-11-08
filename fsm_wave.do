onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /fsm_testbench/clock_period
add wave -noupdate /fsm_testbench/clk
add wave -noupdate /fsm_testbench/reset
add wave -noupdate /fsm_testbench/enter
add wave -noupdate /fsm_testbench/exit
add wave -noupdate /fsm_testbench/increaseTime
add wave -noupdate -radix unsigned /fsm_testbench/hours
add wave -noupdate /fsm_testbench/endDay
add wave -noupdate /fsm_testbench/dut1/ps
add wave -noupdate /fsm_testbench/dut1/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3153 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 136
configure wave -valuecolwidth 121
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
WaveRestoreZoom {0 ps} {4043 ps}
