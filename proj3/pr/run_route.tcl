
source setup.tcl
set begintime [clock seconds]
open_mw_lib ./work
open_mw_cel ${modname}_cts


check_routeability

#set_delay_calculation -arnoldi

set_net_routing_layer_constraints \
    -max_layer_mode hard -max_layer_name M6 -min_layer_name M1 {*/*/*} 

set_si_options -route_xtalk_prevention true\
	 -delta_delay true \
	 -min_delta_delay true \
	 -static_noise true\
	 -max_transition_mode normal_slew \
	 -timing_window true 


set_route_options -groute_timing_driven true \
	-groute_incremental true \
	-track_assign_timing_driven true \
	-same_net_notch check_and_fix 



route_opt -effort high \
	-stage global \
	-incremental 

save_mw_cel
	
#route_opt -effort high \
#	-stage track \
#	-xtalk_reduction \
#	-incremental 

#save_mw_cel

route_opt -effort high \
	-stage detail \
	-xtalk_reduction \
	-incremental 

save_mw_cel

# Uncomment the following lines to see an example of repeater insertion
# on one net.  Note that you may need to run more detail-route iterations
# to complete the routing with no violations.
#
# current_instance u_logic
# report_net -physical n4928
# add_buffer_on_route -repeater_distance 100 n4928 \ 
#                      saed32lvt_ff1p16v25c/NBUFFX2_LVT
# report_net -physical n4928
                     

#verify_zrt_route

#insert_redundant_vias -auto_mode insert

insert_stdcell_filler -cell_without_metal SHFILL1 \
	-connect_to_power VDD -connect_to_ground VSS
	
insert_stdcell_filler -cell_without_metal SHFILL2 \
	-connect_to_power VDD -connect_to_ground VSS

insert_well_filler -layer NWELL \
	-higher_edge max -lower_edge min
	
	
	
preroute_standard_cells -nets VDD -connect horizontal
preroute_standard_cells -nets VSS -connect horizontal

verify_pg_nets
verify_pg_nets  -pad_pin_connection all
	
	
set_write_stream_options \
      -map_layer ${SAED32_ROOT}/tech/milkyway/saed32nm_1p9m_gdsout_mw.map \
      -output_filling fill \
      -child_depth 20 \
      -output_outdated_fill  \
      -output_pin  {text geometry}
write_stream -lib work -format gds -cells ${modname}_routed ${modname}.gds

extract_rc -coupling_cap

write_parasitics -output ${modname}_routed.spef

#write_verilog -pg -no_physical_only_cells xbar_wpg.v

report_timing

write_verilog -no_physical_only_cells ${modname}_routed.v

write_def -output ${modname}.def



save_mw_cel -as ${modname}_routed
set endtime [clock seconds]
set timestr [timef [expr $endtime-$begintime]]
puts "run_route.tcl completed successfully (elapsed time: $timestr actual)"
exit
