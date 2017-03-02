LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Tabela_de_Controle is
	port( clk 	   		: in  std_logic;
			rst				: in  std_logic;
			DVC 				: in  std_logic;
			FontePc			: in  std_logic;
			ehbeqadiantado : out std_logic
	);
end Tabela_de_Controle;

architecture behavior of Tabela_de_Controle is
signal saidasoma,entradareg, entradasoma0,entradasoma1 ,saidareg :std_logic_vector(7 downto 0); 
signal temp1,temp2:std_logic;
signal FontePc1 : std_logic;
-------------------------------------------------------------------
component mux2to1
		generic(
			DATA_WIDTH : natural := 32
		);
		port (
			SEL : in  STD_LOGIC;
			A, B   : in  STD_LOGIC_VECTOR((DATA_WIDTH-1) downto 0);
			X   : out STD_LOGIC_VECTOR((DATA_WIDTH-1) downto 0)
		);
end component;
--------------------------------------------------------------------
component flipflop
		generic(
			DATA_WIDTH : natural := 32
		);
		port(
			clk, rst : in std_logic;  
			D : in  std_logic_vector ((DATA_WIDTH-1) downto 0);  
			Q : out std_logic_vector ((DATA_WIDTH-1) downto 0)
		);  
end component;
--------------------------------------------------------------------
component addSub
		generic(
			DATA_WIDTH : natural := 8
		);

		port(
			a		: in std_logic_vector ((DATA_WIDTH-1) downto 0);
			b		: in std_logic_vector ((DATA_WIDTH-1) downto 0);
			add_sub : in std_logic;
			result	: out std_logic_vector ((DATA_WIDTH-1) downto 0)
		);
end component;
component flipflop1b
		port(
		clk, rst : in std_logic;  
		D : in  std_logic;  
		Q : out std_logic
	);
end component;
---------------------------------------------------------------------
begin
	
	FontePc1 <= FontePc;
	flip1 : flipflop1b port map(clk,rst,DVC,temp1);
	flip2 : flipflop1b port map(clk,rst,temp1,temp2);
	entradasoma1(0) <= temp2;
	entradasoma1(7 downto 1)<="0000000";
	-------------------------------------------------------------------------
	mux_seta_primeiro_op: mux2to1 GENERIC MAP (DATA_WIDTH => 8) PORT MAP (
		sel => rst,
		A => saidareg,
		B => "10000000",
		X => entradasoma0
	);
	-------------------------------------------------------------------------
	AJUSTA_ENDERECO_RECOVERY: addSub GENERIC MAP (DATA_WIDTH => 8) PORT MAP (
		a => entradasoma0,
		b => entradasoma1, 
		add_sub => FontePc1, -- FontePc controla a soma ou sub com o DVC
		result => entradareg
	);
	--------------------------------------------------------------------------
	PIPE_unico: flipflop GENERIC MAP (DATA_WIDTH => 8) PORT MAP (
		clk => clk,
		rst => rst,
		D => entradareg,
		Q => saidareg
	);
	--------------------------------------------------------------------------
	process(entradareg,clk)
	begin
	if(clk'event and clk='1')then
		if(entradareg > "10000000" )then  
			ehbeqadiantado <='1';
		else
			ehbeqadiantado <='0';
		end if;
	end if;
	end process;
end behavior;
