library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2to11bit is
	Port (
		SEL : in  STD_logic;
		A, B   : in  STD_logic;
		X   : out STD_LOGIC
	);
end mux2to11bit;

architecture behavioral of mux2to11bit is
begin
    X <= A when (SEL = '0') else B;
end behavioral;