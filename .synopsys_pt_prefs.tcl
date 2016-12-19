pt_use_pref_reader_version 1 {
# PrimeTime version K-2015.06-SP1
# Preferences written on Thu Sep 8 14:16:17 2016
gui_set_var -name {read_pref_file} -value {true}
gui_create_pref_key -category {ComparisonTable} -key {NegativeColor} -value_type {string} -value {#ff7f00}
gui_create_pref_key -category {ComparisonTable} -key {PositiveColor} -value_type {string} -value {#4daf4a}
gui_create_pref_key -category {ComparisonTable} -key {ZeroColor} -value_type {string} -value {white}
gui_create_pref_key -category {Globals} -key {selection_logging_disabled} -value_type {bool} -value {true}
gui_create_pref_key -category {TimingAnalysisDriver} -key {path_options} -value_type {string} -value {-delay_type max -nworst 1 -max_paths 20 -include_hierarchical_pins     -path_type full_clock_expanded}
gui_create_pref_key -category {menu_items} -key {SelectByNameDialog} -value_type {string} -value {
  snpsMenu::add_menu  -internal_cmd "showSelectByNameDialog()"  -menu "${BaseName}&By Name..."  -enable "package require snpsGuiMenuEnable ; ::snpsGuiMenuEnable::has_current_design"  -hot_key "Ctrl+B"  -help_string  {Select objects using find command and filter_collection syntax.}  -nolog
}
gui_create_pref_key -category {menu_items} -key {SelectSelectionListDialog} -value_type {string} -value {
  snpsMenu::add_menu  -internal_cmd "showSelectionListDialog()"  -menu "${BaseName}Selection &List"  -help_string {Show list of selected objects.}
}
gui_create_pref_key -category {pathInspect} -key {mask_clock_paths_common_path} -value_type {bool} -value {false}
gui_create_pref_key -category {schematic} -key {showInfoTip} -value_type {bool} -value {true}
gui_create_pref_key -category {schematic} -key {toplevel} -value_type {bool} -value {true}
gui_set_var -name {read_pref_file} -value {false}
}
