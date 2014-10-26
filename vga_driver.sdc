create_clock -period 20.000 -name clk_50 [get_ports clk_50]
create_clock -period 40.000 -name pclk [get_ports pclk]
create_generated_clock -divide_by 2 -source [get_ports clk_50] -name clk_25 [get_registers clk_gen:clk_divider|clk_25]

derive_clock_uncertainty