onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /datapath_testbench/clock_period
add wave -noupdate /datapath_testbench/clk
add wave -noupdate /datapath_testbench/reset
add wave -noupdate /datapath_testbench/enter
add wave -noupdate /datapath_testbench/exit
add wave -noupdate -radix unsigned /datapath_testbench/hours
add wave -noupdate -radix unsigned /datapath_testbench/num
add wave -noupdate -radix unsigned /datapath_testbench/maxCar
add wave -noupdate -radix unsigned /datapath_testbench/rushHour
add wave -noupdate -radix unsigned /datapath_testbench/endHour
add wave -noupdate /datapath_testbench/noRush
add wave -noupdate /datapath_testbench/noEnd
add wave -noupdate /datapath_testbench/rush
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2795 ps} 0}
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
WaveRestoreZoom {0 ps} {28386 ps}
