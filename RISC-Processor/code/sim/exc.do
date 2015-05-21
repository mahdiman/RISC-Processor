vsim -gui work.execute
add wave -position insertpoint  \
sim:/execute/*
force -freeze sim:/execute/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/execute/ra 2'h1 0
force -freeze sim:/execute/rb 2'h2 0
force -freeze sim:/execute/rp 2'h0 0
force -freeze sim:/execute/op1 8'h10 0
force -freeze sim:/execute/op2 8'h0F 0
force -freeze sim:/execute/pipeline 8'h0F 0
force -freeze sim:/execute/old_flags 4'h2 0
force -freeze sim:/execute/in_condition 2'h0 0
# NOP
force -freeze sim:/execute/mode 6'h00 0
force -freeze sim:/execute/sel_dst 0 0
force -freeze sim:/execute/cin 0 0
force -freeze sim:/execute/mem 0 0
force -freeze sim:/execute/wr 0 0
force -freeze sim:/execute/change_flag 0 0

run
# MOV
force -freeze sim:/execute/mode 6'h00 0
force -freeze sim:/execute/sel_dst 1 0
force -freeze sim:/execute/cin 0 0
force -freeze sim:/execute/mem 0 0
force -freeze sim:/execute/wr 1 0
force -freeze sim:/execute/change_flag 0 0

run
# ADD
force -freeze sim:/execute/mode 6'h01 0
force -freeze sim:/execute/sel_dst 0 0
force -freeze sim:/execute/cin 0 0
force -freeze sim:/execute/mem 0 0
force -freeze sim:/execute/wr 1 0
force -freeze sim:/execute/change_flag 1 0

run
# SUB
force -freeze sim:/execute/mode 6'h02 0
force -freeze sim:/execute/sel_dst 0 0
force -freeze sim:/execute/cin 1 0
force -freeze sim:/execute/mem 0 0
force -freeze sim:/execute/wr 1 0
force -freeze sim:/execute/change_flag 1 0

run
# AND
force -freeze sim:/execute/mode 6'h04 0
force -freeze sim:/execute/sel_dst 0 0
force -freeze sim:/execute/cin 0 0
force -freeze sim:/execute/mem 0 0
force -freeze sim:/execute/wr 1 0
force -freeze sim:/execute/change_flag 1 0

run
# OR
force -freeze sim:/execute/sel_dst 0 0
force -freeze sim:/execute/mode 6'h05 0
force -freeze sim:/execute/cin 0 0
force -freeze sim:/execute/mem 0 0
force -freeze sim:/execute/wr 1 0
force -freeze sim:/execute/change_flag 1 0

run
# RLC
force -freeze sim:/execute/sel_dst 1 0
force -freeze sim:/execute/mode 6'h0E 0
force -freeze sim:/execute/cin 1 0
force -freeze sim:/execute/mem 0 0
force -freeze sim:/execute/wr 1 0
force -freeze sim:/execute/change_flag 1 0

run
# RLC
force -freeze sim:/execute/sel_dst 1 0
force -freeze sim:/execute/mode 6'h0A 0
force -freeze sim:/execute/cin 1 0
force -freeze sim:/execute/mem 0 0
force -freeze sim:/execute/wr 1 0
force -freeze sim:/execute/change_flag 1 0

run
# SETC
force -freeze sim:/execute/sel_dst 0 0
force -freeze sim:/execute/mode 6'h15 0
force -freeze sim:/execute/cin 0 0
force -freeze sim:/execute/op1 8'h01 0
force -freeze sim:/execute/op2 8'h04 0
force -freeze sim:/execute/mem 0 0
force -freeze sim:/execute/wr 0 0
force -freeze sim:/execute/change_flag 1 0

run
# CLRC
force -freeze sim:/execute/sel_dst 0 0
force -freeze sim:/execute/mode 6'h14 0
force -freeze sim:/execute/cin 0 0
force -freeze sim:/execute/op1 8'h05 0
force -freeze sim:/execute/op2 8'hFB 0
force -freeze sim:/execute/mem 0 0
force -freeze sim:/execute/wr 0 0
force -freeze sim:/execute/change_flag 1 0

run
# PUSH
force -freeze sim:/execute/sel_dst 0 0
force -freeze sim:/execute/mode 6'h10 0
force -freeze sim:/execute/cin 0 0
force -freeze sim:/execute/op1 8'h10 0
force -freeze sim:/execute/op2 8'hFB 0
force -freeze sim:/execute/mem 1 0
force -freeze sim:/execute/wr 0 0
force -freeze sim:/execute/change_flag 0 0
force -freeze sim:/execute/in_condition 2'h1 0
run
# POP
force -freeze sim:/execute/sel_dst 1 0
force -freeze sim:/execute/mode 6'h10 0
force -freeze sim:/execute/cin 1 0
force -freeze sim:/execute/op1 8'h10 0
force -freeze sim:/execute/op2 8'hFB 0
force -freeze sim:/execute/mem 1 0
force -freeze sim:/execute/wr 1 0
force -freeze sim:/execute/change_flag 0 0
force -freeze sim:/execute/in_condition 2'h2 0
run
# OUT
force -freeze sim:/execute/sel_dst 0 0
force -freeze sim:/execute/mode 6'h10 0
force -freeze sim:/execute/cin 0 0
force -freeze sim:/execute/mem 0 0
force -freeze sim:/execute/wr 0 0
force -freeze sim:/execute/change_flag 0 0
force -freeze sim:/execute/in_condition 2'h3 0
run
# IN
force -freeze sim:/execute/sel_dst 0 0
force -freeze sim:/execute/mode 6'h00 0
force -freeze sim:/execute/cin 0 0
force -freeze sim:/execute/mem 0 0
force -freeze sim:/execute/wr 1 0
force -freeze sim:/execute/change_flag 0 0
run
# NOT
force -freeze sim:/execute/sel_dst 0 0
force -freeze sim:/execute/mode 6'h07 0
force -freeze sim:/execute/cin 0 0
force -freeze sim:/execute/mem 0 0
force -freeze sim:/execute/wr 1 0
force -freeze sim:/execute/change_flag 1 0
run
# NEG
force -freeze sim:/execute/sel_dst 0 0
force -freeze sim:/execute/mode 6'h00 0
force -freeze sim:/execute/cin 1 0
force -freeze sim:/execute/mem 0 0
force -freeze sim:/execute/wr 1 0
force -freeze sim:/execute/change_flag 1 0
run
# INC
force -freeze sim:/execute/sel_dst 0 0
force -freeze sim:/execute/mode 6'h00 0
force -freeze sim:/execute/cin 1 0
force -freeze sim:/execute/mem 0 0
force -freeze sim:/execute/wr 1 0
force -freeze sim:/execute/change_flag 1 0
run
# DEC
force -freeze sim:/execute/sel_dst 0 0
force -freeze sim:/execute/mode 6'h03 0
force -freeze sim:/execute/cin 0 0
force -freeze sim:/execute/mem 0 0
force -freeze sim:/execute/wr 1 0
force -freeze sim:/execute/change_flag 1 0
run