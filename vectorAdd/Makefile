# Location of the CUDA Toolkit
CUDA_PATH       := /usr/local/cuda-7.5
NVCC := $(CUDA_PATH)/bin/nvcc
CCFLAGS := -O2

build: vectorAdd

vectorAdd.o:vectorAdd.cu
	$(NVCC) $(INCLUDES) $(CCFLAGS) $(GENCODE_FLAGS) -o $@ -c $<

vectorAdd: vectorAdd.o
	$(NVCC) $(LDFLAGS) $(GENCODE_FLAGS) -o $@ $+ $(LIBRARIES)

run: build
	$(EXEC) ./vectorAdd

clean:
	rm -f vectorAdd *.o
