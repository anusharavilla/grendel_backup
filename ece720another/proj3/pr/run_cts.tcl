
source setup.tcl
set begintime [clock seconds]
open_mw_lib ./work
open_mw_cel ${modname}_placed


check_legality

set_clock_tree_options -clock_trees $clkname \
		-insert_boundary_cell true \
		-ocv_clustering true \
		-buffer_relocation true \
		-buffer_sizing true \
		-gate_relocation true \
		-gate_sizing true \
		-max_transition 0.1 \
		-leaf_max_transition 0.4 \
		-target_skew 0 \
		-layer_list {M1 M2 M3 M4 M5 M6 M7} -layer_list_for_sinks {M1 M2 M3 M4 M5 M6 M7}
		
set cts_use_debug_mode true
set cts_do_characterization true

set_attribute [get_flat_cells] is_soft_fixed true

clock_opt -fix_hold_all_clocks  -continue_on_missing_scandef

# DEFINING POWER/GROUND NETS AND PINS			 
#derive_pg_connection -power_net VDD		\
#			 -ground_net VSS	\
#			 -power_pin VDD		\
#			 -ground_pin VSS	
			 
preroute_standard_cells -nets VSS -connect horizontal
preroute_standard_cells -nets VDD -connect horizontal

verify_pg_nets
verify_pg_nets  -pad_pin_connection all

report_clock_tree  -operating_condition max
report_timing -delay_type min
report_timing -delay_type max

save_mw_cel -as ${modname}_cts
set endtime [clock seconds]
set timestr [timef [expr $endtime-$begintime]]
puts "run_cts.tcl completed successfully (elapsed time: $timestr actual)"
exit
