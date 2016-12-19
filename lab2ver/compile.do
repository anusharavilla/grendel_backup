# Compilation File for Modelsim

vlog -sv test_memory.sv
vlog memory.vp
vsim -novopt test_memory
#log -r /*
run -all
$stop


