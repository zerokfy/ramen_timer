## Generated SDC file "timer_top.out.sdc"

## Copyright (C) 2020  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and any partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel FPGA IP License Agreement, or other applicable license
## agreement, including, without limitation, that your use is for
## the sole purpose of programming logic devices manufactured by
## Intel and sold by Intel or its authorized distributors.  Please
## refer to the applicable agreement for further details, at
## https://fpgasoftware.intel.com/eula.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 20.1.1 Build 720 11/11/2020 SJ Lite Edition"

## DATE    "Tue Jun 01 23:38:33 2021"

##
## DEVICE  "10M50DAF484C7G"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {CLK_50M} -period 20.000 -waveform { 0.000 1.000 } [get_ports {CLK_50M}]


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {CLK_10K} -source [get_ports {CLK_50M}] -duty_cycle 50/1 -multiply_by 1 -divide_by 5000 -master_clock {CLK_50M} [get_nets {ALTPLL_inst|altpll_component|auto_generated|wire_pll1_clk[0]}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {CLK_10K}] -rise_to [get_clocks {CLK_10K}]  1.000  
set_clock_uncertainty -rise_from [get_clocks {CLK_10K}] -fall_to [get_clocks {CLK_10K}]  1.000  
set_clock_uncertainty -fall_from [get_clocks {CLK_10K}] -rise_to [get_clocks {CLK_10K}]  1.000  
set_clock_uncertainty -fall_from [get_clocks {CLK_10K}] -fall_to [get_clocks {CLK_10K}]  1.000  


#**************************************************************
# Set Input Delay
#**************************************************************

set_input_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {KEY[0]}]
set_input_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {KEY[1]}]


#**************************************************************
# Set Output Delay
#**************************************************************

set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[0][0]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[0][1]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[0][2]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[0][3]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[0][4]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[0][5]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[0][6]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[0][7]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[1][0]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[1][1]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[1][2]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[1][3]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[1][4]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[1][5]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[1][6]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[1][7]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[2][0]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[2][1]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[2][2]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[2][3]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[2][4]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[2][5]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[2][6]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[2][7]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[3][0]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[3][1]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[3][2]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[3][3]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[3][4]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[3][5]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[3][6]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[3][7]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[4][0]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[4][1]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[4][2]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[4][3]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[4][4]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[4][5]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[4][6]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[4][7]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[5][0]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[5][1]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[5][2]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[5][3]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[5][4]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[5][5]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[5][6]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {HEX_7SEG[5][7]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {LEDR[0]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {LEDR[1]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {LEDR[2]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {LEDR[3]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {LEDR[4]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {LEDR[5]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {LEDR[6]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {LEDR[7]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {LEDR[8]}]
set_output_delay -add_delay  -clock [get_clocks {CLK_10K}]  1000.000 [get_ports {LEDR[9]}]


#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

