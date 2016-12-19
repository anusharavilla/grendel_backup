
# The following targets build the memory image required for exercising
# the Cortex-M0 DesignStart Verilog RTL:

CPROGRAM	= fibonacci

ARMCCFLAGS	= --tool_variant=mdk_pro --cpu=cortex-m0 -c
ARMLDFLAGS	= --tool_variant=mdk_pro --cpu=cortex-m0 --ro-base=0x0 --info=totals --map

# Extract RAM binary image from ELF file
ram.bin:	$(CPROGRAM).elf
	fromelf --tool_variant=mdk_pro --bin --output $@ $<

# Link object file with library to produce ELF
%.elf:	%.o
	armlink $(ARMLDFLAGS) --first='$<(vectors)' -o $@ $<

# Compile C program to object file
%.o:	%.c
	armcc $(ARMCCFLAGS) -o $@ $<
 
TBENCHSRC	= AHBLiteStub.sv tb.v
STDCELLSRC      = /afs/eos.ncsu.edu/lockers/research/ece/wdavis/tech/synopsys/SAED32/SAED32_EDK/lib/stdcell_lvt/verilog/saed32nm_lvt.v
SRCDIR		= ../src/rtl
GATESRCDIR		= ../src/gate
#changed by anusha
VERILOGSRC	= $(wildcard $(SRCDIR)/*.v)
GATESRC		= $(wildcard $(GATESRCDIR)/*.v)
SVERILOGSRC	= $(wildcard ./*.sv)
VERILOGTOP	= tb

 
# Mentor Graphics QuestaSim/ModelSim
simans:	$(VERILOGSRC) $(SVERILOGSRC) $(TBENCHSRC) $(STDCELLSRC) ram.bin
	vlib work
	vlog $(STDCELLSRC) $(VERILOGSRC) $(SVERILOGSRC) $(TBENCHSRC)
	vopt $(VERILOGTOP) -o $(VERILOGTOP)_opt
	vsim $(VERILOGTOP)_opt -c -do "run -all" 

gui:	$(VERILOGSRC) $(SVERILOGSRC) $(TBENCHSRC) $(STDCELLSRC) ram.bin
	vlib work
	vlog $(STDCELLSRC) $(VERILOGSRC) $(SVERILOGSRC) $(TBENCHSRC)
	vsim -novopt $(VERILOGTOP)

gatesim:	$(GATESRC) $(TBENCHSRC) $(STDCELLSRC) ram.bin
		vlib work
		vlog $(STDCELLSRC) $(GATESRC) $(TBENCHSRC)
		vopt $(VERILOGTOP) -o $(VERILOGTOP)_opt
		vsim $(VERILOGTOP)_opt -c -do "run -all" 

gategui:	$(GATESRC) $(TBENCHSRC) $(STDCELLSRC) ram.bin
		vlib work
		vlog $(STDCELLSRC) $(GATESRC) $(TBENCHSRC)
		vsim -novopt $(VERILOGTOP) 


clean:
	-rm -rf work
	-rm -f ram.bin
	-rm -f *.elf
	-rm -f *.o
	-rm -f transcript
	-rm -f vsim.wlf

pwr:	sim
	python addr_stat_modified.py sim.out

sim:	 
	make 
	make simans > sim.out
	python addr_stat.py sim.out > addr.out
	make gatesim
	python simout.py
	 
	
