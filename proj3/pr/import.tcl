source  setup.tcl

create_mw_lib -technology ${SAED32_ROOT}/tech/milkyway/saed32nm_1p9m_mw.tf \
    -mw_reference_library \
    ${SAED32_ROOT}/lib/stdcell_lvt/milkyway/saed32nm_lvt_1p9m \
    -hier_separator {/} \
    -bus_naming_style {[%d]} \
    -open ./work

import_designs -format verilog \
    -top ${modname} \
    -cel ${modname}_init ${GATE_DIR}/${modname}_final.v

source  constraints.tcl
