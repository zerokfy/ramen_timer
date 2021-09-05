vsim \
  -c sim_top \
  -L altera_mf_ver \
  +UVM_TESTNAME=sample_test \
  -do "run -all"

