onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /control_testbench/clock_period
add wave -noupdate /control_testbench/clk
add wave -noupdate /control_testbench/reset
add wave -noupdate /control_testbench/enter
add wave -noupdate /control_testbench/exit
add wave -noupdate /control_testbench/increaseTime
add wave -noupdate /control_testbench/full
add wave -noupdate -radix unsigned /control_testbench/num
add wave -noupdate /control_testbench/HEX0
add wave -noupdate /control_testbench/HEX1
add wave -noupdate /control_testbench/HEX2
add wave -noupdate /control_testbench/HEX3
add wave -noupdate /control_testbench/HEX4
add wave -noupdate /control_testbench/HEX5
add wave -noupdate /control_testbench/dut1/statemachine/ps
add wave -noupdate /control_testbench/dut1/statemachine/ns
add wave -noupdate -radix unsigned /control_testbench/dut1/hours
add wave -noupdate -radix unsigned /control_testbench/dut1/maxCar
add wave -noupdate -radix unsigned -childformat {{{/control_testbench/dut1/rushHour[2]} -radix unsigned} {{/control_testbench/dut1/rushHour[1]} -radix unsigned} {{/control_testbench/dut1/rushHour[0]} -radix unsigned}} -subitemconfig {{/control_testbench/dut1/rushHour[2]} {-radix unsigned} {/control_testbench/dut1/rushHour[1]} {-radix unsigned} {/control_testbench/dut1/rushHour[0]} {-radix unsigned}} /control_testbench/dut1/rushHour
add wave -noupdate -radix unsigned /control_testbench/dut1/endHour
add wave -noupdate -radix unsigned /control_testbench/dut1/out
add wave -noupdate /control_testbench/dut1/data/rush
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3381 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 91
configure wave -valuecolwidth 72
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
