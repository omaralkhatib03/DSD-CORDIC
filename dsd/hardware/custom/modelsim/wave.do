onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb2/dut/clk
add wave -noupdate /tb2/dut/reset_n
add wave -noupdate /tb2/dut/read
add wave -noupdate /tb2/dut/write
add wave -noupdate /tb2/dut/writedata
add wave -noupdate /tb2/dut/address
add wave -noupdate /tb2/dut/readdata
add wave -noupdate /tb2/dut/writereg
add wave -noupdate /tb2/dut/readreg
add wave -noupdate /tb2/dut/xo
add wave -noupdate /tb2/dut/ao
add wave -noupdate /tb2/dut/xu
add wave -noupdate -expand /tb2/dut/clk_enables
add wave -noupdate /tb2/dut/i
add wave -noupdate /tb2/dut/result
add wave -noupdate /tb2/dut/clk_en
add wave -noupdate -expand /tb2/dut/acc_clk_enables
add wave -noupdate /tb2/dut/j
add wave -noupdate /tb2/dut/state
add wave -noupdate /tb2/dut/next_state
add wave -noupdate /tb2/dut/n
add wave -noupdate /tb2/dut/q
add wave -noupdate /tb2/dut/acc_en
add wave -noupdate /tb2/dut/acc_in
add wave -noupdate /tb2/dut/k
add wave -noupdate /tb2/dut/delay_read
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1471 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ps} {4 ns}
