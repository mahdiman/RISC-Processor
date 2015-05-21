vsim -gui work.main
add wave -position insertpoint  \
sim:/main/clk \
sim:/main/int \
sim:/main/addr \
sim:/main/en1 \
sim:/main/en2 \
sim:/main/en3 \
sim:/main/en4 \
sim:/main/b1_pre \
sim:/main/b1 \
sim:/main/b2 \
sim:/main/b3 \
sim:/main/port_out \
sim:/main/r0 \
sim:/main/r1 \
sim:/main/r2 \
sim:/main/r3 \
sim:/main/exc_cin \
sim:/main/exc_fa \
sim:/main/exc_fb \
sim:/main/exc_flag_change \
sim:/main/exc_mem_access \
sim:/main/exc_mode \
sim:/main/exc_br_mode \
sim:/main/exc_op1 \
sim:/main/exc_op2 \
sim:/main/exc_ra \
sim:/main/exc_rb \
sim:/main/exc_sel_dst \
sim:/main/exc_write_back \
sim:/main/mem_access \
sim:/main/mem_access_address \
sim:/main/mem_access_en \
sim:/main/mem_access_result \
sim:/main/mem_access_src_regIn \
sim:/main/mem_access_src_regOut \
sim:/main/mem_access_toWB \
sim:/main/mem_access_wbIn \
sim:/main/mem_access_wbOut \
sim:/main/old_flags \
sim:/main/main_conditions \
sim:/main/out_flags \
sim:/main/saved_flags \
sim:/main/port_in \
sim:/main/result1 \
sim:/main/result2 \
sim:/main/result \
sim:/main/rout1 \
sim:/main/rout2 \
sim:/main/rout \
sim:/main/dec_pc_read \
sim:/main/exc_pc_read \
sim:/main/pc_dirty \
sim:/main/select_result \
sim:/main/flush \
sim:/main/rst \
sim:/main/stall \
sim:/main/pc_next \
sim:/main/pc \
sim:/main/write_back
mem load -i {C:/Modeltech_pe_edu_10.3c/examples/ARCH\arch2/memory/code_ram.mem} /main/u1/my_ram/ram
mem load -i {C:/Modeltech_pe_edu_10.3c/examples/ARCH\arch2/memory/data_ram.mem} /main/u4/m0/ram
force -freeze sim:/main/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/main/rst 1 0
force -freeze sim:/main/int 0 0
force -freeze sim:/main/port_in BB 0
run
force -freeze sim:/main/rst 0 0
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
force -freeze sim:/main/int 1 0
run
force -freeze sim:/main/int 0 0
run