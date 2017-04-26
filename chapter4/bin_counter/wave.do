onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /bin_counter_tb/clk
add wave -noupdate /bin_counter_tb/uut/reset
add wave -noupdate /bin_counter_tb/uut/syn_clr
add wave -noupdate /bin_counter_tb/uut/load
add wave -noupdate /bin_counter_tb/uut/en
add wave -noupdate /bin_counter_tb/uut/up
add wave -noupdate -expand /bin_counter_tb/uut/d
add wave -noupdate -expand /bin_counter_tb/uut/q
add wave -noupdate /bin_counter_tb/uut/min_tick
add wave -noupdate /bin_counter_tb/uut/max_tick
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 225
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {255760848 ns} {255760989780 ps}
