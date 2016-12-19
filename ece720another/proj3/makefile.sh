#find ./ -type f -exec sed -i 's/set modname cortex_soc/set modname cortex_soc/g' {} \;

#find ./ -type f -exec sed -i 's/set CLK_PER 5/set CLK_PER 5/g' {} \;
cd v/synth
make clean
make
cd ../../pr
make clean
make
make timing
#cd ../v/synth
#make pt
#make ptsi
