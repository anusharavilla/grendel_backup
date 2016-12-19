Synopsys IC Compiler Place & Route Tutorial #2
(c) 11/8/2016 W. Rhett Davis & Sumon Dey

This tutorial introduces clock-tree synthesis and repeater insertion
with Synopsys IC Compiler Synopsys PrimeTime at NC State University.
It also includes the files necessary to run Signal Integrity and Power
Estimation using Synopsys PrimeTime-SI, PrimeTime-PX and Mentor
Graphics Questa/Modelsim.  It is assumed that you have already worked
through Place & Route Tutorial #1 and know how to perform the
base-line physical design flow.

1) Log in to a Linux Lab Machine

2) Synthesize the netlist file

(copy the v/sim and v/src/rtl direcotries from the cortexmods.tar.gz
distribution into this directory tree)
cd v/synth
make

Ensure that the file .synopsys_dc.setup exists in this directory,
or the target will not be made successfully.

3) Place & Route the design 

When modifying this tutorial for another design, remember that you
will probably need to make the following changes:
 setup.tcl - modname & CLK_PER
 Makefile  - MODNAME

Use the following commands to run through the complete tutorial.
Refer to the pr_tut2.pdf file for a more detailed explanation.

cd ../../pr
make

Note that each of the targets listed above creates a log file called
run_[target].log.  Look in these files for more information.

If execution fails on any one target, you will likely need to manually
enter the command "exit" followed by return.  Then you should be able to 
examine the log file to debug the problem.

Finally, note the dependencies for each target, as defined in the Makefile:
- init: depends on verilog netlist and updates the file .init when complete
- place: depends on .init and updates the file .place when complete
- cts: depends on .place and updates the file .cts when complete
- route: depends on .cts and updates the file .route when complete

The main thing to remember when using this flow is that each step
updates the file-modification time of a "checkpoint" dotfile whenever
it completes.  If you want to re-run a step, then you will need to
touch the checkpoint dotfile for the previous step.  For example, to
re-run the cts and route steps, you will need to use the command
"touch .place" following by "make".


4) Verify the Timing

When modifying this tutorial for another design, remember that you
will probably need to modify the parameters at the beginning of 
the files run_pt.tcl, run_ptsi.tcl, and Makefile.

make pt
make ptsi

5) Optimize the design

See notes in the accompanying PDF file


