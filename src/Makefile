compile: data_array.vhd data_array_tb.vhd
	ghdl -a -fexplicit --ieee=synopsys data_array.vhd data_array_tb.vhd
clean:
	rm *.o work-obj93.cf *.vcd
simulate: data_array.o
	ghdl -e data_array_tb
wave:
	ghdl -r data_array_tb --vcd=data_array_tb.vcd
