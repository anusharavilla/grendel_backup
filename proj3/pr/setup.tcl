# setup name of the clock in your design.
set clkname HCLK

# set variable "modname" to the name of topmost module in design
set modname cortex_soc

# set variable "RTL_DIR" to the HDL directory w.r.t synthesis directory
set RTL_DIR    ../v/src/rtl

# set variable "GATE_DIR" to the output directory w.r.t synthesis directory
set GATE_DIR    ../v/src/gate

#set the number of digits to be used for delay results
set report_default_significant_digits 4

set CLK_PER 5

# Define a helpful function for printing out time strings
proc timef {sec} {
  set hrs [expr $sec/3600]
  set sec [expr $sec-($hrs*3600)]
  set min [expr $sec/60]
  set sec [expr $sec-($min*60)]
  return "${hrs}h ${min}m ${sec}s"
}
