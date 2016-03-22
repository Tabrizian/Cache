# VHDL files
FILES = src/data_array.vhd src/tag_valid_array.vhd

# Testbench
TESTDIR = test
TESTFILES = $(TESTDIR)/data_array_tb.vhd $(TESTDIR)/tag_valid_array_tb.vhd
SUFFIX = _out# Suffix of files created using -e option
MODULE = tag_valid_array# Show wave of this module
STOPTIME = 40ns

# Run
RUN_FLAGS = --stop-time=$(STOPTIME) --vcd=$(MODULE).vcd

# GHDL command
GHDL_CMD = ghdl
GHDL_FLAGS = -fexplicit --ieee=synopsys

all: | ghdl-compile ghdl-simulate show

ghdl-compile: $(FILES) $(TESTFILES)
	$(GHDL_CMD) -a $(GHDL_FLAGS) $(FILES) $(TESTFILES)
clean:
	rm *.o work-obj93.cf *.vcd *$(SUFFIX)
ghdl-simulate:
	$(GHDL_CMD) -e -o $(MODULE)$(SUFFIX) $(MODULE)
show:
	$(GHDL_CMD) -r $(MODULE)$(SUFFIX) $(RUN_FLAGS)
	gtkwave $(MODULE).vcd
