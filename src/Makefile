compile: data_array.vhd data_array_tb.vhd
	ghdl -a -fexplicit --ieee=synopsys data_array.vhd data_array_tb.vhd
clean:
	rm *.o work-obj93.cf *.vcd *_out
simulate: data_array.o
	ghdl -e -o data_array_tb_out data_array_tb
wave:
	ghdl -r data_array_tb_out --stop-time=40ns --vcd=data_array_tb.vcd
show:
	gtkwave data_array_tb.vcd
all: | compile simulate wave show
