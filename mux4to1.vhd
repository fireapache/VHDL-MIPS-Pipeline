library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux4to1 is
	generic(
		DATA_WIDTH : natural := 32
	);
	Port (
		SEL : in  STD_LOGIC_VECTOR(1 DOWNTO 0);
		A, B, C, D : in  STD_LOGIC_VECTOR((DATA_WIDTH-1) downto 0);
		X   : out STD_LOGIC_VECTOR((DATA_WIDTH-1) downto 0)
	);
end mux4to1;

architecture behavioral of mux4to1 is
begin
    
	 with SEL select X <=
			A when "00",
			B when "01",
			C when "10",
			D when "11",
			"00000000000000000000000000000000" when others;
	 
end behavioral;