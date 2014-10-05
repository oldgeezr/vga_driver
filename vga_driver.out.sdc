## Generated SDC file "vga_driver.out.sdc"

## Copyright (C) 1991-2014 Altera Corporation. All rights reserved.
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, the Altera Quartus II License Agreement,
## the Altera MegaCore Function License Agreement, or other 
## applicable license agreement, including, without limitation, 
## that your use is for the sole purpose of programming logic 
## devices manufactured by Altera and sold by Altera or its 
## authorized distributors.  Please refer to the applicable 
## agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus II"
## VERSION "Version 14.0.0 Build 200 06/17/2014 SJ Web Edition"

## DATE    "Sat Oct 04 22:42:09 2014"

##
## DEVICE  "EP4CE22F17C6"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {clk_gen:clk_divider|clk_25} -period 1.000 -waveform { 0.000 0.500 } [get_registers {clk_gen:clk_divider|clk_25}]
create_clock -name {clk_50} -period 10.000 -waveform { 0.000 5.000 } [get_pins {clk_50~input|i}]
create_clock -name {clk_25} -period 40.000 -waveform { 0.000 20.000 } [get_nets {clk_divider|clk_25}]


#**************************************************************
# Create Generated Clock
#**************************************************************



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {clk_25}] -rise_to [get_clocks {clk_25}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {clk_25}] -fall_to [get_clocks {clk_25}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {clk_25}] -rise_to [get_clocks {clk_50}]  0.030  
set_clock_uncertainty -rise_from [get_clocks {clk_25}] -fall_to [get_clocks {clk_50}]  0.030  
set_clock_uncertainty -rise_from [get_clocks {clk_25}] -rise_to [get_clocks {clk_gen:clk_divider|clk_25}]  0.010  
set_clock_uncertainty -rise_from [get_clocks {clk_25}] -fall_to [get_clocks {clk_gen:clk_divider|clk_25}]  0.010  
set_clock_uncertainty -fall_from [get_clocks {clk_25}] -rise_to [get_clocks {clk_25}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk_25}] -fall_to [get_clocks {clk_25}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk_25}] -rise_to [get_clocks {clk_50}]  0.030  
set_clock_uncertainty -fall_from [get_clocks {clk_25}] -fall_to [get_clocks {clk_50}]  0.030  
set_clock_uncertainty -fall_from [get_clocks {clk_25}] -rise_to [get_clocks {clk_gen:clk_divider|clk_25}]  0.010  
set_clock_uncertainty -fall_from [get_clocks {clk_25}] -fall_to [get_clocks {clk_gen:clk_divider|clk_25}]  0.010  


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



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

