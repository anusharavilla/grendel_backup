
CXX = /afs/eos.ncsu.edu/lockers/research/ece/wdavis/tools/mips/gcc492_64/bin/g++492

# Common rules
include makefile.include

# Specify objects and target(s) to build
SRCS = $(wildcard src/*.cpp)
TARGET = Cortex-M0.x
CPROGRAM = fibonacci

# Determine others...
GENDIR = ./$(CONFIG)/gen
BUILDDIR = ./$(CONFIG)
WRAPPERLIB = scx-Cortex-$(CONFIG)
EVSLIB  = Cortex-$(CONFIG)
CXXFLAGS += -I$(GENDIR)
LDFLAGS += -L$(BUILDDIR) -l$(WRAPPERLIB) -lcomponents -lpvbus \
		   $(PVLIB_HOME)/lib/Linux$(BITNESS_IN_NAME)_GCC-$(GCC_VER)/libarmctmodel.a \
		   -lscx -lfmruntime -lsystemc -l$(EVSLIB) -ldl -lrt \
		   -Wl,-rpath,'$$ORIGIN'

# Determine commands
SIMGEN_CMD = $(MAXCORE_HOME)/bin/simgen -p Cortex-M0.sgproj \
			 --num-build-cpus $(J) --configuration $(CONFIG) \
			 $(SIMGENFLAGS)
CXX_CMD = $(CXX) $(CXXFLAGS) -o $(TARGET) $(SRCS) $(LDFLAGS)

# Local rules

.SUFFIXES:



.PHONY: dbg_gcc47_64 rel_gcc47_64
.PHONY: dbg_gcc48_64 rel_gcc48_64
.PHONY: dbg_gcc49_64 rel_gcc49_64
.PHONY: dbg_gcc47_64_clean rel_gcc47_64_clean
.PHONY: dbg_gcc48_64_clean rel_gcc48_64_clean
.PHONY: dbg_gcc49_64_clean rel_gcc49_64_clean

sim:
	time ./Cortex-M0.x -a ../image/$(CPROGRAM).axf

gdb:
	gdb ./Cortex-M0.x

dbg_gcc47_64 rel_gcc47_64 dbg_gcc48_64 rel_gcc48_64 dbg_gcc49_64 rel_gcc49_64:
	$(SIMGEN_CMD) -b
	cp $(BUILDDIR)/lib$(EVSLIB).so ./
	$(CXX_CMD)

dbg_gcc47_64_clean rel_gcc47_64_clean dbg_gcc48_64_clean rel_gcc48_64_clean dbg_gcc49_64_clean rel_gcc49_64_clean:
	-$(SIMGEN_CMD) --clean
	-rm -f $(TARGET)
	-rm -f ./lib$(EVSLIB).so
	-rm -rf Linux64-Release-GCC-4.9
	-rm -rf Linux64-Debug-GCC-4.9
	-rm -f libMAXCOREInitSimulationEngine.so.2
	-rm -f libSDL-1.2.so.0.11.4
	-rm -f libarmctmodel.so


