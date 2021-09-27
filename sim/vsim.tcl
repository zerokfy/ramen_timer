vsim \
  -c sim_top \
  -L altera_mf_ver \
  +UVM_TESTNAME=timer_test \
  -do "run -all;"

add wave -position end  sim:/sim_top/sys_if/CLK_50M
add wave -position end  sim:/sim_top/sys_if/RST
add wave -position end  sim:/sim_top/tif/KEY
add wave -position end  sim:/sim_top/tif/HEX_7SEG
add wave -position end  sim:/sim_top/tif/LEDR

