compile: data_array.vhd data_array_t.vhdl
	ghdl -a -fexplicit --ieee=synopsys data_array.vhd
clean: data_array.o
	rm data_array.o work-obj93.cf
simulate: data_array.o
	ghdl -e data_array_t
wave:
	ghdl -r data_array_t --vcd=data_array_t.vcd
