#! usr/bin/bash
echo "start"
#grep -rl "set CLK_PER" * | xargs sed -i 's/set CLK_PER [0-9]/set CLK_PER 3/'
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
