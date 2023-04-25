.PHONY: clean build sim wave
SHELL = /bin/bash

VCS_BUILD_OPTS  = -sverilog
VCS_BUILD_OPTS += -debug_pp
VCS_BUILD_OPTS += +vcs+vcdpluson
VCS_BUILD_OPTS += +vcs+lic+wait

VCS_OPTIONS  = +vcs+vcdpluson
VCS_OPTIONS += +vcs+vcdplusmemon
VCS_OPTIONS += +vcs+vcdplusautoflushon
VCS_OPTIONS += +vcs+lic+wait
# top level module
#TOP=adder_tb
#TOP=test_flop_r
TOP=p_test
# Checks all verilog files in flist.vcs and overwrite result/simv only when necessary.
build: 
	source /ad/eng/bin/engenv.sh
	module load synopsys/Q-2020.03-SP2
	vcs  $(VCS_BUILD_OPTS) -f flist.vcs -Mdir=result/csrc -top $(TOP) -o result/simv_$(TOP)


# Run simulation if result/simv was updated
result/$(TOP).vpd: result/simv_$(TOP)
	##########    Simulating    ##########
	cd result; ./simv_$(TOP) $(VCS_OPTIONS) +vpdfile+$(TOP).vpd

# First run build to check changes in verilog files.
# Then re-run simulation if necessary.
sim: build
	@$(MAKE) result/$(TOP).vpd


wave: sim
	##########    Starting DVE    ##########
	cd result; dve -vpd $(TOP).vpd  &


clean: 
	rm -rf result
	mkdir result
