# ----------------------------
# Info
# ----------------------------
help:
	@echo ""
	@echo "       Available commands:"
	@echo "  -----------------------------"
	@echo ""
	@echo "  Simulation Commands:"
	@echo "  -> build-simulation      Build simulation with verilator using the functional verification stack image"
	@echo "  -> run-simulation        Run simulation with verilator using the functional verification stack image"
	@echo ""


# ----------------------------
# Simulation Command
# ----------------------------

.PHONY: build-simulation
build-simulation:
	docker run --rm -it \
	  -v $$(pwd):/work \
		dv-func:latest \
	  bash -lc 'cd /work && verilator --sv -Wno-fatal --binary -j $$(nproc) --top-module tbench_top \
	    +incdir+$$UVM_HOME +define+UVM_NO_DPI +incdir+$$(pwd) \
	    $$UVM_HOME/uvm_pkg.sv $$(pwd)/sig_pkg.sv $$(pwd)/tb.sv'

.PHONY: run-simulation
run-simulation:
	docker run --rm -it \
	  -v $$(pwd):/work \
		dv-func:latest \
		bash -lc './obj_dir/Vtbench_top +UVM_TESTNAME=sig_model_test'
