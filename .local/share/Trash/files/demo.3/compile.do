vlog *.v 
vlog *.vp
vlog -sv testbench.sv

vsim -novopt testbench 

run -all

