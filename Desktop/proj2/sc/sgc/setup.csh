add ds5-2016.24
set newlibs = ( \
  /afs/eos.ncsu.edu/lockers/research/ece/wdavis/tools/mips/gcc492_64/lib64 \
  )

# Extend LD_LIBRARY_PATH
if ( ! $?LD_LIBRARY_PATH ) then
    setenv LD_LIBRARY_PATH
endif
foreach dir ($newlibs)
    set present = `printenv LD_LIBRARY_PATH | /bin/grep $dir`
    if ($present == "") then
        setenv LD_LIBRARY_PATH ${dir}:${LD_LIBRARY_PATH}
    endif
    unset present
end
unset dir newdirs newlibs
                            
