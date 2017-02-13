library ieee;  
use ieee.std_logic_1164.all;  
 
entity flipflop1b is
	port(
		clk, rst : in std_logic;  
		D : in  std_logic;  
		Q : out std_logic
	);  
end flipflop1b;

architecture rtl of flipflop1b is
	signal Temp: std_logic;
begin  
	process (clk, rst)
	begin  
		if (rst='1') then  
			Temp <= '0';  
		elsif (rising_edge(clk))then  
			Temp <= D; 
		end if;  
	end process;
	
	Q <= Temp;
end rtl;

