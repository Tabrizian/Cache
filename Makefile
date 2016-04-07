# VHDL files
SRCDIR = src
FILES = $(SRCDIR)/data_array.vhd $(SRCDIR)/tag_valid_array.vhd \
		$(SRCDIR)/miss_hit_logic.vhd $(SRCDIR)/lru_array.vhd \
		$(SRCDIR)/cache.vhd $(SRCDIR)/mux.vhd $(SRCDIR)/controller.vhd \
		$(SRCDIR)/cache_ram.vhd $(SRCDIR)/ram.vhd

# Testbench
TESTDIR = test
TESTFILES = $(TESTDIR)/data_array_tb.vhd $(TESTDIR)/tag_valid_array_tb.vhd \
			$(TESTDIR)/miss_hit_logic_tb.vhd $(TESTDIR)/lru_array_tb.vhd \
			$(TESTDIR)/cache_tb.vhd $(TESTDIR)/mux_tb.vhd \
			$(TESTDIR)/cache_ram_tb.vhd
SUFFIX = _out# Suffix of files created using -e option
MODULE = cache_ram_tb# Show wave of this module
STOPTIME = 3500ns

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
