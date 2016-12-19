ECE 720 - Electronic System Level & Physical Design
DRAM Controller, Bus, and Stub Simulation
(c) 2012-2015 By W. Rhett Davis

Certain files in this archive are Copyright ARM, Ltd. and are for use
only by NCSU Students.  For these files, appropriate copyright notices
are included in the header.  We are not licensed to distribute these files!

This directory contains the files necessary to compile a C-program to run
on the ARM DesignStart Cortex M0 System-on-Chip.  Both RTL and Gate-Level
simulations are supported. 

Files:
 
src/rtl/            - This directory contains the complete RTL code for the
                        SoC.  See the README.txt file in that directory
                        for details on each file.
src/gate/           - This directory contains the complete gate-level 
                        description for the SoC.                       
sim/fibonacci.c     - Code to compute Fibonacci numbers, to be used to compare
                        RTL simulation time to TLM simulation time.
sim/Makefile        - Makefile for the fibonacci.c program and verilog 
                        simulation with Mentor Graphics Questa
sim/tb.v            - Test-bench to load ram.bin (the compiled binary for
                        fibonacci.c) into memory and simulate with the 
                        SoC.  This file has been extensively modified from the 
                        original ARM DesignStart Cortex-M0 test-bench.
sim/AHBLiteStub.sv  - Stub for generating AHB-Lite transactions
sim/xact.txt        - Transaction source-file for the stub
sim/modelsim.ini    - Setup file for Mentor Graphics Modelsim/Questa
sim/setup.csh       - Setup script for Mentor Graphics Questa and ARM DS5
                        for verilog simulation and ARM C-compilation.
sim/addr_stat.py    - Python script to print out address-access statistics
                        to be used with the "Transaction Dump" process. 
synth/              - Directory with synthesis and power-analysis scripts

Directions:

1) Change to the "sim" directory
2) Use "source setup.csh" to setup your environment
3) Use "make" to build the ram.bin file
4) Use "make sim" to execute the Verilog simulation

To Execute Power Analysis

1) Uncomment the line that defines the macro VCD at the top of the 
   sim/tb.v file.
2) Change the SRCDIR variable in the file sim/Makefile from ../src/rtl
   to ../src/gate
3) Use "make sim" again to execute the Verilog simulation and generate
   the waves.vcd file
4) Change to the "synth" directory
5) Use "make ptpx" to run power analysis

Notes:

*  Change the SRCDIR variable in sim/Makefile to ../src/gate to switch
   from RTL simulation to gate-level simulation.

*  Use the "make clean" command to delete all generated files, in order
   to prepare the directory for archiving.

*  Use "make gui" to execute the Questa graphical user interface.
   In this mode, you must enter the command "run -all" to execute the 
   simulation, after adding the desired waveforms to the viewer.
   (Be sure to answer "no" when asked if you are sure that you
   want to end the simulation.  Answer "yes" will exit the GUI.)
   It is possible to use the command in conjunction with "make sim"
   to avoid restarting the GUI, by entering the command "restart"
   after rebuilding the simulation.

*  Use the Transaction-Dump process to dump a convenient trace of all bus
   transactions.  To activate this process, uncomment the line that
   defines the macro XACT_DUMP at the top of the tb.v file.

*  To generate address access statistics, activate the transaction-dump
   process and parse the simulaiton output with addr_stat.py as follows:

     % make sim > sim.out
     % python addr_stat.py sim.out

   Three address ranges are included, corrsponding to the program memory, 
   stack memory, and console.  The ranges cover the entire 32-bit address 
   space to help identify unwanted transactions to other locations.
   To modify the ranges, change the "logs" variable in the Python script.

*  Change the PERIOD variable in synth/run_ptpx.tcl to get average power
   at periodic intervals.  Make sure to set the MAX_SIM_TIME variable 
   in this file as well to match the end-time of the simulation.

