vsim -gui work.main
add wave -position insertpoint  \
sim:/main/clk \
sim:/main/rst \
sim:/main/addr \
sim:/main/old_flags \
sim:/main/main_conditions \
sim:/main/out_flags \
sim:/main/saved_flags \
sim:/main/save_flags \
sim:/main/restore_flags \
sim:/main/port_in \
sim:/main/port_out \
sim:/main/pc_next \
sim:/main/pc \
sim:/main/int \
sim:/main/r0 \
sim:/main/r1 \
sim:/main/r2 \
sim:/main/r3 \
sim:/main/flush \
sim:/main/result \
sim:/main/rout \
sim:/main/stall \
sim:/main/write_back
mem load -i {/home/ahmad/Desktop/RISC/arch2/memory/code_ram.mem} /main/u1/my_ram/ram
mem load -i {/home/ahmad/Desktop/RISC/arch2/memory/code_ram.mem} /main/u4/m0/ram
force -freeze sim:/main/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/main/rst 1 0
force -freeze sim:/main/port_in 45 0
force -freeze sim:/main/int 0 0
run
force -freeze sim:/main/rst 0 0
run
run
run
run
force -freeze sim:/main/port_in 05 0
run
force -freeze sim:/main/port_in 70 0
run
force -freeze sim:/main/port_in 126 0
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run -continue
run
run



