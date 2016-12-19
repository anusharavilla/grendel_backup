
source setup.tcl
set begintime [clock seconds]

open_mw_lib ./work
open_mw_cel ${modname}_init

place_opt -effort high -optimize_dft -congestion -continue_on_missing_scandef


legalize_placement -effort high -incremental 

set_fix_multiple_port_nets -all -buffer_constants

place_opt -effort high -optimize_dft -congestion -continue_on_missing_scandef

legalize_placement -effort high -incremental 

preroute_standard_cells -nets VSS -connect horizontal
preroute_standard_cells -nets VDD -connect horizontal


verify_pg_nets  -pad_pin_connection all

report_timing

save_mw_cel -as ${modname}_placed

set endtime [clock seconds]
set timestr [timef [expr $endtime-$begintime]]
puts "run_place.tcl completed successfully (elapsed time: $timestr actual)"
exit
