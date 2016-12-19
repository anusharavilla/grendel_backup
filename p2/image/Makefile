CPROGRAM	= fibonacci

ARMCCFLAGS	= --tool_variant=mdk_pro --cpu=cortex-m0 -c
ARMLDFLAGS	= --tool_variant=mdk_pro --cpu=cortex-m0 --ro-base 0x8000

all: 	$(CPROGRAM).axf

# Link object file with library to produce ELF
%.axf:	%.o
	armlink $(ARMLDFLAGS) -o $@ $<

# Compile C program to object file
%.o:	%.c
	armcc $(ARMCCFLAGS) -o $@ $<

clean:
	rm *.axf

sim:  
	./fibonnaci.out





