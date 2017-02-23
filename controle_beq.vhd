library ieee;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_1164.ALL;

entity controle_beq is 
	port( clk 	   		: in  std_logic;
			rst				: in  std_logic;
			DVC 				: in  std_logic;
			FontePc			: in  std_logic;
			ehbeqadiantado : out std_logic
		);
end controle_beq;

architecture behavior of controle_beq is 
signal temp : std_logic;
component Tabela_de_controle
	port( clk 	   		: in  std_logic;
			rst				: in  std_logic;
			DVC 				: in  std_logic;
			FontePc			: in  std_logic;
			ehbeqadiantado : out std_logic
	);
end component;
begin
		table:Tabela_de_controle port map(clk,rst,DVC,FontePc,temp);
	   ehbeqadiantado <= temp;
end behavior;