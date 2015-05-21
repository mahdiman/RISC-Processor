vsim -gui work.main
add wave -position insertpoint  \
sim:/main/addr \
sim:/main/b1 \
sim:/main/b1_pre \
sim:/main/b2 \
sim:/main/b2_pre \
sim:/main/b3 \
sim:/main/b3_pre \
sim:/main/clk \
sim:/main/dec_cin \
sim:/main/dec_fa \
sim:/main/dec_fb \
sim:/main/dec_flag_change \
sim:/main/dec_mem_access \
sim:/main/dec_mode \
sim:/main/dec_op1 \
sim:/main/dec_op2 \
sim:/main/dec_ra \
sim:/main/dec_rb \
sim:/main/dec_sel_dst \
sim:/main/dec_write_back \
sim:/main/en1 \
sim:/main/en2 \
sim:/main/en3 \
sim:/main/en4 \
sim:/main/exc_cin \
sim:/main/exc_fa \
sim:/main/exc_fb \
sim:/main/exc_flag_change \
sim:/main/exc_mem_access \
sim:/main/exc_mode \
sim:/main/exc_op1 \
sim:/main/exc_op2 \
sim:/main/exc_ra \
sim:/main/exc_rb \
sim:/main/exc_sel_dst \
sim:/main/exc_write_back \
sim:/main/in_condition \
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
sim:/main/out_condition \
sim:/main/out_flags \
sim:/main/pc \
sim:/main/pc_inc \
sim:/main/port_in \
sim:/main/port_out \
sim:/main/r0 \
sim:/main/r1 \
sim:/main/r2 \
sim:/main/r3 \
sim:/main/result \
sim:/main/rout \
sim:/main/rst \
sim:/main/stall \
sim:/main/write_back

mem load -i {C:/Modeltech_pe_edu_10.3c/examples/ARCH/arch2/memory/code_ram.mem} /main/u1/my_ram/ram
mem load -i {C:/Modeltech_pe_edu_10.3c/examples/ARCH/arch2/memory/data_ram.mem} /main/u4/m0/ram
force -freeze sim:/main/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/main/rst 1 0
force -freeze sim:/main/r0 8'h00 0
force -freeze sim:/main/r1 8'h10 0
force -freeze sim:/main/r2 8'h01 0
force -freeze sim:/main/r3 8'h11 0
force -freeze sim:/main/stall 0 0 
run
force -freeze sim:/main/rst 0 0
run