vsim -gui work.accessmem
# vsim -gui work.accessmem 
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.math_real(body)
# Loading ieee.numeric_std(body)
# Loading work.accessmem(accessmem_arch)
# Loading work.ram(syncrama)
# vsim -gui work.accessmem 
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.math_real(body)
# Loading ieee.numeric_std(body)
# Loading work.accessmem(accessmem_arch)
# Loading work.ram(syncrama)
mem load -i {../memory/data_ram.mem} /accessmem/m0/ram
add wave -position insertpoint  \
sim:/accessmem/clk \
sim:/accessmem/execResult \
sim:/accessmem/memAccess \
sim:/accessmem/memAddress \
sim:/accessmem/memOut \
sim:/accessmem/memWrite \
sim:/accessmem/n \
sim:/accessmem/srcRegIn \
sim:/accessmem/srcRegOut \
sim:/accessmem/toWB \
sim:/accessmem/wbIn \
sim:/accessmem/wbOut
force -freeze sim:/accessmem/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/accessmem/memAddress 00 0
force -freeze sim:/accessmem/memAccess 1 0
force -freeze sim:/accessmem/wbIn 0 0
force -freeze sim:/accessmem/srcRegIn 0 0
force -freeze sim:/accessmem/execResult FF 0
run
force -freeze sim:/accessmem/execResult FE 0
force -freeze sim:/accessmem/memAddress 01 0
run
force -freeze sim:/accessmem/wbIn 1 0
force -freeze sim:/accessmem/execResult 00 0
force -freeze sim:/accessmem/memAddress 00 0
run
force -freeze sim:/accessmem/memAddress 01 0
run
force -freeze sim:/accessmem/memAddress 00 0
run
force -freeze sim:/accessmem/memAddress 0F 0
run
force -freeze sim:/accessmem/execResult CC 0
force -freeze sim:/accessmem/wbIn 0 0
run
force -freeze sim:/accessmem/wbIn 1 0
run -continue
run
run -continue
force -freeze sim:/accessmem/memAddress 00 0
run
force -freeze sim:/accessmem/memAddress 0F 0
run
force -freeze sim:/accessmem/memAccess 0 0
force -freeze sim:/accessmem/execResult FA 0
run
force -freeze sim:/accessmem/memAddress 00 0
run


