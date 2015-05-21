vsim work.branch_component

add wave -position insertpoint  \
sim:/branch_component/r0 \
sim:/branch_component/r1 \
sim:/branch_component/r2 \
sim:/branch_component/r3 \
sim:/branch_component/ra \
sim:/branch_component/rb \
sim:/branch_component/value \
sim:/branch_component/fetch \
sim:/branch_component/flags \
sim:/branch_component/mode \
sim:/branch_component/PC \
sim:/branch_component/N \
sim:/branch_component/Z \
sim:/branch_component/V \
sim:/branch_component/C \
sim:/branch_component/Loop_condition \
sim:/branch_component/Jmp_condition \
sim:/branch_component/Call_condition \
sim:/branch_component/Ret_condition \
sim:/branch_component/Rti_condition \
sim:/branch_component/R_rb

# Changing content of the four registers and assuming a value for fetch
force -freeze sim:/branch_component/r0 8'b00001000 0
force -freeze sim:/branch_component/r1 8'b00110011 0
force -freeze sim:/branch_component/r2 8'b01010101 0
force -freeze sim:/branch_component/r3 8'b00001111 0
force -freeze sim:/branch_component/fetch 8'b00111111 0
run

# Changing mode to 0000, the PC should depend on Z flag.
# Changing content of flag register. Raising the Z flag.
# The PC should not read any value yet, as rb has no value yet
force -freeze sim:/branch_component/mode 4'b0000 0
force -freeze sim:/branch_component/flags 4'b0100 0
run

# Changing rb to 1. Value of PC should change to the value of r1
force -freeze sim:/branch_component/rb 2'b01 0
run

# Changing rb to 2. Value of PC should change to the value of r2
force -freeze sim:/branch_component/rb 2'b10 0
run

# Changing mode to 0001, the PC should depend on N register.
# Changing content of flag register. Raising the N flag.
# The value of the PC should remain as it is
force -freeze sim:/branch_component/mode 4'b0001 0
force -freeze sim:/branch_component/flags 4'b1000 0
run

# Changing mode to 0010, the PC should depend on C register.
# Changing content of flag register. Raising the N flag.
# The value of the PC should remain as it is
force -freeze sim:/branch_component/mode 4'b0010 0
force -freeze sim:/branch_component/flags 4'b0010 0
run

# Changing mode to 0011, the PC should depend on V register.
# Changing content of flag register. Raising the N flag.
# The value of the PC should remain as it is
force -freeze sim:/branch_component/mode 4'b0011 0
force -freeze sim:/branch_component/flags 4'b0001 0
run

# Changing mode to 0100, the PC should depend on LOOP , i.e.: contain the value of R[rb], assuming the LOOP condition is computed in decode.
force -freeze sim:/branch_component/mode 4'b0100 0
run

# Changing mode to 0101, the PC should depend on JMP , i.e.: contain the value of R[rb], assuming the JMP condition is computed in decode.
force -freeze sim:/branch_component/mode 4'b0101 0
run

# Changing mode to 0110, the PC should depend on CALL , i.e.: contain the value of R[rb], assuming the CALL condition is computed in decode.
force -freeze sim:/branch_component/mode 4'b0110 0
run

# Changing value to 01110111
force -freeze sim:/branch_component/value 4'b01110111 0
run

# Changing mode to 0111, the PC should depend on RET , i.e.: contain the value of value, assuming the loop condition is computed in decode.
force -freeze sim:/branch_component/mode 4'b0111 0
run

# Changing mode to 1000, the PC should depend on RTI , i.e.: contain the value of value, assuming the loop condition is computed in decode.
force -freeze sim:/branch_component/mode 4'b1000 0
run
