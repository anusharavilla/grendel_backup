
MODNAME=CORTEXM0DS

all: route

INIT = .init
.PHONY: init
init: $(INIT)
$(INIT): constraints.tcl run_init.tcl ../v/src/gate/$(MODNAME)_final.v
	tcsh -c "add synopsys2015 ; \
	icc_shell -f run_init.tcl |& tee run_init.log ; \
	touch $(INIT)"

PLACE = .place
.PHONY: place
place: $(PLACE)
$(PLACE): $(INIT)
	tcsh -c "add synopsys2015 ; \
	icc_shell -f run_place.tcl |& tee run_place.log ; \
	touch $(PLACE)"

CTS = .cts
.PHONY: cts
cts: $(CTS)
$(CTS): $(PLACE)
	tcsh -c "add synopsys2015 ; \
	icc_shell -f run_cts.tcl |& tee run_cts.log ; \
	touch $(CTS)"

ROUTE = .route
.PHONY: route
route: $(ROUTE)
$(ROUTE): $(CTS)
	tcsh -c "add synopsys2015 ; \
	icc_shell -f run_route.tcl |& tee run_route.log ; \
	touch $(ROUTE)"

.PHONY: timing
timing: $(ROUTE)
	tcsh -c "add synopsys2015 ; \
	icc_shell -f run_timing.tcl |& tee run_timing.log"


gui:
	tcsh -c "add synopsys2015 ; \
	icc_shell -gui"

clean:
	-rm -rf work
	-rm icc_output.txt
	-rm -rf *.log
	-rm -rf *.v
	-rm -rf *.def
	-rm -rf *.gds
	-rm -rf net.gcts
	-rm -rf buffer.gcts
	-rm -rf net.acts
	-rm -rf *.min
	-rm -rf *.max
	-rm -rf legalizer_debug_plots
	-rm -f .init .place .cts .route
