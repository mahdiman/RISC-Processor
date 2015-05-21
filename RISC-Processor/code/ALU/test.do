vsim -gui work.pdp11
add wave -position insertpoint  \
sim:/pdp11/readDecoder2 \
sim:/pdp11/nAddress \
sim:/pdp11/r0 \
sim:/pdp11/r1 \
sim:/pdp11/r2 \
sim:/pdp11/r3 \
sim:/pdp11/tmp \
sim:/pdp11/src \
sim:/pdp11/dst \
sim:/pdp11/mar \
sim:/pdp11/mdr \
sim:/pdp11/ir \
sim:/pdp11/z \
sim:/pdp11/y \
sim:/pdp11/flag \
sim:/pdp11/buss \
sim:/pdp11/mOut \
sim:/pdp11/mdrIn \
sim:/pdp11/writeDecoder \
sim:/pdp11/aluOut \
sim:/pdp11/rst \
sim:/pdp11/mdrEn \
sim:/pdp11/readEn2 \
sim:/pdp11/readEn3 \
sim:/pdp11/readEn4 \
sim:/pdp11/writeEn \
sim:/pdp11/clk \
sim:/pdp11/mClk \
sim:/pdp11/mdrClk \
sim:/pdp11/mWrite \
sim:/pdp11/mRead \
sim:/pdp11/clrY \
sim:/pdp11/carryIn \
sim:/pdp11/cWord \
sim:/pdp11/sWr1 \
sim:/pdp11/readDecoder3 \
sim:/pdp11/readDecoder4 \
sim:/pdp11/sRd2 \
sim:/pdp11/sRd3 \
sim:/pdp11/sRd4 \
sim:/pdp11/aluSelection \
sim:/pdp11/flags
mem load -skip 0 -filltype inc -filldata 0 -fillradix hexadecimal /pdp11/l27/ram
force -freeze sim:/pdp11/buss 16'h0004 0
force -freeze sim:/pdp11/clk 0 0, 1 {50 ns} -r 100
force -freeze sim:/pdp11/rst 1 0
run

force -freeze sim:/pdp11/readEn3 1 0
force -freeze sim:/pdp11/mdrEn 0 0
force -freeze sim:/pdp11/readEn2 0 0
force -freeze sim:/pdp11/readEn4 0 0
force -freeze sim:/pdp11/writeEn 0 0
force -freeze sim:/pdp11/rst 0 0
force -freeze sim:/pdp11/sRd3 2'h0 0
force -freeze sim:/pdp11/mWrite 0 0
force -freeze sim:/pdp11/mRead 0 0
force -freeze sim:/pdp11/clrY 0 0
force -freeze sim:/pdp11/carryIn 0 0

run
