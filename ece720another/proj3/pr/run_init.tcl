
set begintime [clock seconds]

source -echo import.tcl

#################################################################
###	FLOORPLAN	 
#################################################################
create_floorplan -core_utilization 1 -start_first_row -flip_first_row -left_io2core 1 -bottom_io2core 1 -right_io2core 1 -top_io2core 1


# DEFINING POWER/GROUND NETS AND PINS			 
derive_pg_connection -power_net VDD		\
			 -ground_net VSS		\
			 -power_pin VDD		\
			 -ground_pin VSS	
			 
# CREATING POWER RECTANGULAR RING		

create_rectangular_rings  -nets  {VDD VSS}  -left_offset 0.2 -left_segment_layer M8 -right_offset 0.2 -right_segment_layer M8 -bottom_offset 0.2 -bottom_segment_layer M9 -extend_bh -top_offset 0.2 -top_segment_layer M9



create_power_straps  -direction horizontal  -nets  {VDD}  -layer M9 -configure  groups_and_step  -num_groups 100  -step 5
create_power_straps  -direction horizontal  -start_at 2.5 -nets  {VSS}  -layer M9 -configure  groups_and_step  -num_groups 100 -step 5
create_power_straps  -direction vertical  -nets  {VDD}  -layer M8 -configure  groups_and_step  -num_groups 100 -step 5
create_power_straps  -direction vertical  -start_at 2.5 -nets  {VSS}  -layer M8 -configure  groups_and_step  -num_groups 100 -step 5

report_timing

save_mw_cel
close_mw_cel
close_mw_lib

set endtime [clock seconds]
set timestr [timef [expr $endtime-$begintime]]
puts "run_init.tcl completed successfully (elapsed time: $timestr actual)"
exit
