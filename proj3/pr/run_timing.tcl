###################################################
#
# run_timing.tcl
#
# 4/11/2011 W. Rhett Davis (rhett_davis@ncsu.edu)
# updated 4/5/2012, 3/28/2014, 8/23/2016, 11/30/2016
#
#####################################################

source setup.tcl
set begintime [clock seconds]
open_mw_lib ./work
open_mw_cel ${modname}_routed


set si_enable_analysis TRUE

set_propagated_clock [get_clocks $clkname]
set_clock_uncertainty 0 $clkname

#report_timing -delay_type max > timing_si.rpt

#read_parasitics -keep_capacitive_coupling -format spef "${modname}_${type}.spef.max"
#check_timing -include { no_driving_cell ideal_clocks partial_input_delay \
#                        unexpandable_clocks }

report_timing -nosplit -input_pins -transition_time -crosstalk_delta \
      -delay_type max -path_type full_clock_expanded \
      > timing_si_max.rpt
report_timing -nosplit -input_pins -transition_time -crosstalk_delta \
      -delay_type min -path_type full_clock_expanded \
      > timing_si_min.rpt
report_clock_timing -type summary > timing_si_clock.rpt
#report_si_bottleneck
#report_delay_calculation -crosstalk -from inst1/pin1 -to inst2/pin2
#set_noise_parameters -analysis_type all
report_noise > noise.rpt
#report_noise_calculation -below -high -from inst1/pin1 -to inst2/pin2


set endtime [clock seconds]
set timestr [timef [expr $endtime-$begintime]]
puts "run_timing.tcl completed successfully (elapsed time: $timestr actual)"
exit

