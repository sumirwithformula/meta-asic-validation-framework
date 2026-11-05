IVERILOG ?= iverilog
VVP ?= vvp
VERILATOR ?= verilator
BUILD_DIR ?= build

.PHONY: sim-multiplier lint-multiplier sim-vector-mac lint-vector-mac clean

sim-multiplier:
	mkdir -p $(BUILD_DIR)
	$(IVERILOG) -g2012 -Wall -s tb_signed_multiplier -o $(BUILD_DIR)/tb_multiplier.vvp \
	  rtl/signed_multiplier.sv sim/tb_signed_multiplier.sv
	$(VVP) $(BUILD_DIR)/tb_multiplier.vvp

lint-multiplier:
	$(VERILATOR) --lint-only -Wall --top-module signed_multiplier rtl/signed_multiplier.sv

clean:
	rm -rf $(BUILD_DIR)

sim-vector-mac:
	mkdir -p $(BUILD_DIR)
	$(IVERILOG) -g2012 -Wall -s tb_vector_mac -o $(BUILD_DIR)/tb_vector_mac.vvp \
	  rtl/signed_multiplier.sv rtl/vector_mac.sv sim/tb_vector_mac.sv
	$(VVP) $(BUILD_DIR)/tb_vector_mac.vvp

lint-vector-mac:
	$(VERILATOR) --lint-only -Wall --top-module vector_mac \
	  rtl/signed_multiplier.sv rtl/vector_mac.sv
