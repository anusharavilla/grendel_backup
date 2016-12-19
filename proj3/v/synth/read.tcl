#------------------------------------------------------------
#
# Basic Synthesis Script (TCL format)
#                                  
# Revision History                
#   1/15/03  : Author Shane T. Gehring - from class example
#   2/09/07  : Author Zhengtao Yu      - from class example
#   12/14/07 : Author Ravi Jenkal      - updated to 180 nm & tcl
#
#------------------------------------------------------------

#---------------------------------------------------------
# Read in Verilog file and map (synthesize) onto a generic
# library.
# MAKE SURE THAT YOU CORRECT ALL WARNINGS THAT APPEAR
# during the execution of the read command are fixed 
# or understood to have no impact.
# ALSO CHECK your latch/flip-flop list for unintended 
# latches                                            
#---------------------------------------------------------

read_verilog $RTL_DIR/cortexm0ds_logic.v
read_verilog $RTL_DIR/AHB_Lite_2s.v
read_verilog $RTL_DIR/CORTEXM0DS.v
read_verilog $RTL_DIR/cortex_soc.v
read_verilog $RTL_DIR/DW_memctl.v
read_verilog $RTL_DIR/stub_soc.v
