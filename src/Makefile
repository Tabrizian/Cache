all: | data_array simulate wave show
data_array: data_array.vhd data_array_tb.vhd
	ghdl -a -fexplicit --ieee=synopsys data_array.vhd data_array_tb.vhd
tag_valid: tag_valid_array.vhd tag_valid_array_tb.vhd
	ghdl -a -fexplicit --ieee=synopsys tag_valid_array.vhd tag_valid_array_tb.vhd
clean:
	rm *.o work-obj93.cf *.vcd *_out
simulate: data_array.o tag_valid_array.o
	ghdl -e -o data_array_tb_out data_array_tb
	ghdl -e -o tag_valid_array_tb_out tag_valid_array_tb
wave:
	ghdl -r tag_valid_array_tb_out --stop-time=40ns --vcd=tag_valid_array_tb.vcd
show:
	gtkwave tag_valid_array_tb.vcd
