Procedure to run the code
1. Open the Project file and add all the required .vp, .sv and .v files.
2. Open the code in terminal and perform add modelsim10.3b and setenv MODELSIM modelsim.ini.
3. Then do a vlog of the .v and .vp files using the following commands. vlog *.v
vlog *.vp
4. Since the modelsim.ini we are using is of the version mti_lib, use the following vlib command
vlib mti_lib
5. Then to compile the .sv files use the following command vlog *.sv
6. Then for vsim, do the following
a) vsim &
b) After modelsim opens create a new project inside the same directory as our project folder
c) Add and Copy all the .vp,.v and .sv files from the directory to the project folder.
d) Compile all in modelsim
e) Start Simulation , go to work and add testbench as the top level module.
f) run-all
7. Let the simulation run for at least 1000000 instruction count in testbench. After this time the
coverage will saturate to 100 percent.



