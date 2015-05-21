vsim -gui work.decode
add wave -position insertpoint  \
sim:/decode/*
force -freeze sim:/decode/instruction 8'h00 0
force -freeze sim:/decode/r0 8'h00 0
force -freeze sim:/decode/r1 8'h01 0
force -freeze sim:/decode/r2 8'h10 0
force -freeze sim:/decode/r3 8'h11 0
force -freeze sim:/decode/rst 0 0
run
force -freeze sim:/decode/instruction 8'h06 0
run

force -freeze sim:/decode/instruction 8'h16 0
run

force -freeze sim:/decode/instruction 8'h26 0
run

force -freeze sim:/decode/instruction 8'h36 0
run

force -freeze sim:/decode/instruction 8'h46 0
run

force -freeze sim:/decode/instruction 8'h56 0
run

force -freeze sim:/decode/instruction 8'h60 0
run
force -freeze sim:/decode/instruction 8'h64 0
run
force -freeze sim:/decode/instruction 8'h68 0
run
force -freeze sim:/decode/instruction 8'h6B 0
run

force -freeze sim:/decode/instruction 8'h70 0
run
force -freeze sim:/decode/instruction 8'h74 0
run
force -freeze sim:/decode/instruction 8'h78 0
run
force -freeze sim:/decode/instruction 8'h7B 0
run

force -freeze sim:/decode/instruction 8'h80 0
run
force -freeze sim:/decode/instruction 8'h84 0
run
force -freeze sim:/decode/instruction 8'h88 0
run
force -freeze sim:/decode/instruction 8'h8B 0
run
