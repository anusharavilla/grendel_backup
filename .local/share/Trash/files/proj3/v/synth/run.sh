#! usr/bin/bash
echo "start"
#grep -rl "set CLK_PER" * | xargs sed -i 's/set CLK_PER [0-9]/set CLK_PER 5/'
make clean
make
cd ../../pr
make clean
make
make timing
#cd ../v/synth
#make pt
#make ptsi
echo "All done"
for i in 1 2 3
	echo -e "\a"
