onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/HCLK
add wave -noupdate /tb/HRESETn
add wave -noupdate -radix hexadecimal /tb/HADDR
add wave -noupdate /tb/HBURST
add wave -noupdate /tb/HPROT
add wave -noupdate /tb/HSIZE
add wave -noupdate /tb/HTRANS
add wave -noupdate -radix hexadecimal /tb/HWDATA
add wave -noupdate /tb/HMASTLOCK
add wave -noupdate /tb/HWRITE
add wave -noupdate /tb/HREADY
add wave -noupdate /tb/HRESP
add wave -noupdate /tb/hready_resp_s1
add wave -noupdate /tb/soc/wrapper/M1/not_ready
add wave -noupdate /tb/hready_resp_s2
add wave -noupdate -radix hexadecimal /tb/HRDATA
add wave -noupdate /tb/soc/hsel_s1
add wave -noupdate /tb/soc/hsel_s2
add wave -noupdate /tb/TXEV
add wave -noupdate /tb/LOCKUP
add wave -noupdate /tb/SYSRESETREQ
add wave -noupdate /tb/SLEEPING
add wave -noupdate /tb/ddr_RASn
add wave -noupdate /tb/ddr_CASn
add wave -noupdate /tb/ddr_CSn
add wave -noupdate /tb/ddr_CKE
add wave -noupdate /tb/ddr_ODT
add wave -noupdate /tb/ddr_WEn
add wave -noupdate /tb/ddr_BA
add wave -noupdate -radix hexadecimal /tb/ddr_A
add wave -noupdate /tb/ddr_DQS
add wave -noupdate -radix hexadecimal /tb/ddr_DQ
add wave -noupdate -radix hexadecimal /tb/ddrwm_data_reg
add wave -noupdate /tb/ddrwm_z_reg
add wave -noupdate -radix hexadecimal /tb/ddrwm_write_data
add wave -noupdate /tb/ddrwm_DQS
add wave -noupdate -radix hexadecimal /tb/ddrwm_DQ
add wave -noupdate -radix hexadecimal /tb/soc/wrapper/DC/data_frm_fifo1
add wave -noupdate -radix hexadecimal /tb/soc/wrapper/DC/data_frm_fifo2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4320 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 279
configure wave -valuecolwidth 158
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
configure wave -timelineunits ns
update
WaveRestoreZoom {4200 ns} {4384 ns}
