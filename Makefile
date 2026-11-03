IVERILOG ?= iverilog
VVP ?= vvp
VERILATOR ?= verilator
BUILD_DIR ?= build

.PHONY: sim-multiplier lint-multiplier clean

sim-multiplier:
	mkdir -p $(BUILD_DIR)
	$(IVERILOG) -g2012 -Wall -s tb_signed_multiplier -o $(BUILD_DIR)/tb_multiplier.vvp \
	  rtl/signed_multiplier.sv sim/tb_signed_multiplier.sv
	$(VVP) $(BUILD_DIR)/tb_multiplier.vvp

lint-multiplier:
	$(VERILATOR) --lint-only -Wall --top-module signed_multiplier rtl/signed_multiplier.sv

clean:
	rm -rf $(BUILD_DIR)
