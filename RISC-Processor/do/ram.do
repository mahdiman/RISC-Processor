vsim -gui work.ram
# vsim -gui work.ram 
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.ram(syncrama)
add wave -position insertpoint  \
sim:/ram/n \
sim:/ram/m \
sim:/ram/clk \
sim:/ram/we \
sim:/ram/address \
sim:/ram/datain \
sim:/ram/dataout \
sim:/ram/ram
mem load -i ../memory/data_ram.mem /ram/ram
force -freeze sim:/ram/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/ram/we 1 0
force -freeze sim:/ram/address 00 0
force -freeze sim:/ram/datain FF 0
run
force -freeze sim:/ram/address 01 0
run
run
force -freeze sim:/ram/address 00 0
force -freeze sim:/ram/we 0 0
run
run
force -freeze sim:/ram/address 02 0
run
force -freeze sim:/ram/we 1 0
force -freeze sim:/ram/datain FE 0
run
run

