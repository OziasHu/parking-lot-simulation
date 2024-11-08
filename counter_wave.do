onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /counter_testbench/clock_period
add wave -noupdate /counter_testbench/clk
add wave -noupdate /counter_testbench/reset
add wave -noupdate -radix unsigned /counter_testbench/out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 80
configure wave -valuecolwidth 92
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
WaveRestoreZoom {0 ps} {46864 ps}
