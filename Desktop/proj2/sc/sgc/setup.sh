add ds5-2016.24

# New LD_LIBRARY_PATH Entries
newlib=/afs/eos.ncsu.edu/lockers/research/ece/wdavis/tools/mips/gcc492_64/lib64

if [ -d $newlib ] && [[ ":$LD_LIBRARY_PATH:" != *":$newlib:"* ]]; then
    LD_LIBRARY_PATH="$newlib:${LD_LIBRARY_PATH+":$LD_LIBRARY_PATH"}"
fi


