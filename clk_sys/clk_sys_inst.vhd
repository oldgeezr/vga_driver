	component clk_sys is
		port (
			inclk  : in  std_logic := 'X'; -- inclk
			outclk : out std_logic         -- outclk
		);
	end component clk_sys;

	u0 : component clk_sys
		port map (
			inclk  => CONNECTED_TO_inclk,  --  altclkctrl_input.inclk
			outclk => CONNECTED_TO_outclk  -- altclkctrl_output.outclk
		);

