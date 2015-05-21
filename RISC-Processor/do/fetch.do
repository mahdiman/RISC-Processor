#do file for the fetch module

vsim work.fetch

add wave -position insertpoint  \
sim:/fetch/n \
sim:/fetch/i \
sim:/fetch/clk \
sim:/fetch/pc \
sim:/fetch/instruction \
sim:/fetch/add \
sim:/fetch/PC_incremented


force -freeze sim:/fetch/clk 1 0, 0 {50 ps} -r 100


force -freeze sim:/fetch/pc 00000000 0

run

noforce sim:/fetch/pc
run
run
quit -sim

vsim work.fetch