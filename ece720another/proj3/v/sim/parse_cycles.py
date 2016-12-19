import re
reads=0
writes=0
with open("sim.out") as infile:
     for line in infile:
         m = re.search(r'([0-9]+):\s*Simulation leaving reset.*',line)
         n = re.search(r'([0-9]+):\s*Simulation stop requested by CPU.*',line)
	 if m:
		start_time = int(m.group(1))
	 if n:
		end_time = int(n.group(1))
total_time=end_time - start_time
total_cycles = float(total_time/10)
with open("sim2.out") as infile:
      for line in infile:
	  a = re.search(r'Number of Reads:\s*([0-9]+).*',line)
	  b = re.search(r'Number of Writes:\s*([0-9]+).*',line)
	  if a:
 		reads = reads + int(a.group(1))
	  if b:
		writes = writes + int(b.group(1))
inst= reads + writes			
xfers_per_cycle=inst/total_cycles

print "start time: %d"%start_time
print "end_time: %d"%end_time
print "Reads: %d"%reads
print "Writes: %d"%writes
print "total cycles: %f"%total_cycles
print "xfers per cycle: %f"%xfers_per_cycle
