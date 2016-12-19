import re
read_tot = 0
write_tot = 0
first_done = 0
cps = 0.0
cycles = 0
a = 0.0
b=0.0
with open("sim.out") as f:
    for line in f:
        k=re.search(r'#\s+(\d+): Simulation leaving reset', line)
        if k:
            a = float(k.group(1))
        l=re.search(r'#\s+(\d+): Simulation stop requested by CPU', line)
        if l:
            b = float(l.group(1))
cycles = b-a    

with open("addr.out") as fil:
    for line in fil:
        #searching for number of reads
        read = re.search(r'Number of Reads:\s*(\d+)',line)
        if read:
            read_tot = read_tot + int(read.group(1))
        write = re.search(r'Number of Writes:\s*(\d+)',line)
        if write:
            write_tot = write_tot + int(write.group(1))


mem_trans = float(float(read_tot + write_tot)/float(cycles/10))
print "<<<<ANSWERS>>>>"
#print "Cycles : ", cycles

print "Start   :", float(a)
print "Stop   :", float(b)
print "Reads   :", float(read_tot)
print "Writes   :", float(write_tot)
print "Cycles   :", float(cycles/10)
print "Transfers per cycle   :", mem_trans
