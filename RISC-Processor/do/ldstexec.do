vsim -gui work.ldstexec
# vsim 
# Start time: 10:53:28 on May 09,2015
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.math_real(body)
# Loading ieee.numeric_std(body)
# Loading work.ldstexec(ldstexec_arch)
add wave -position insertpoint  \
sim:/ldstexec/instruction_type \
sim:/ldstexec/mem_access \
sim:/ldstexec/rin \
sim:/ldstexec/rout \
sim:/ldstexec/write_back
force -freeze sim:/ldstexec/instruction_type 4'h0 0
force -freeze sim:/ldstexec/rin 2'h1 0
run
# ** Warning: (vsim-WLF-5000) WLF file currently in use: vsim.wlf
# 
#           File in use by: Ahmad AL-mahdi  Hostname: AHMAD  ProcessID: 3004
# 
#           Attempting to use alternate WLF file "./wlftfbwkqx".
# ** Warning: (vsim-WLF-5001) Could not open WLF file: vsim.wlf
# 
#           Using alternate file: ./wlftfbwkqx
# 
force -freeze sim:/ldstexec/instruction_type 4'h1 0
run
force -freeze sim:/ldstexec/instruction_type 4'h3 0
run

force -freeze sim:/ldstexec/instruction_type 4'h2 0
run
force -freeze sim:/ldstexec/instruction_type 4'h4 0
run
force -freeze sim:/ldstexec/instruction_type 4'h5 0
run
force -freeze sim:/ldstexec/rin 2'h3 0
force -freeze sim:/ldstexec/instruction_type 4'h6 0
run
force -freeze sim:/ldstexec/instruction_type 4'h7 0
run
force -freeze sim:/ldstexec/instruction_type 4'h2 0
run

