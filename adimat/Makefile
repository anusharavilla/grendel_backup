# Location of the CUDA Toolkit
CUDA_PATH       := /usr/local/cuda-7.5
NVCC := $(CUDA_PATH)/bin/nvcc
CCFLAGS := -O2

build: abc

abc.o:abc.cu
	$(NVCC) $(INCLUDES) $(CCFLAGS) $(GENCODE_FLAGS) -o $@ -c $<

abc: abc.o
	$(NVCC) $(LDFLAGS) $(GENCODE_FLAGS) -o $@ $+ $(LIBRARIES)

run: build
	$(EXEC) ./abc

clean:
	rm -f abc *.o
