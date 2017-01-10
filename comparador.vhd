LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- REG SOURCE
-- REG2 ->
-- REG3 ->
-- sinal1 = true , reg2 = rs0
-- sinal2 = true , reg3 = rs0
-- sinal3 = true , reg2 = rs1
-- sinal4 = true , reg3 = rs1


entity comparador is 
	port( clk : in std_logic;
			rst:in std_logic;
			reg1,reg2,reg3 : in std_logic_vector(4 downto 0);
		   sinal1,sinal2,sinal3,sinal4: out std_logic	
	);
	
end comparador;

architecture behavior of comparador is 
signal rs0,rs1 : std_logic_vector(5 downto 0);-- saidas dos flip flops

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

begin
	------------------------------------------------------------------
			-- REGISTRADOR DE SINAIS SOURCE
	Flip1: flipflop generic map(DATA_WIDTH => 5) PORT MAP(
		clk => clk,
		rst => rst,
		D	 => reg1,
		Q	 => rs0
	);
	Flip2: flipflop generic map(DATA_WIDTH => 5) PORT MAP(
		clk => clk,
		rst => rst,
		D	 => rs0,
		Q	 => rs1
	);
	-------------------------------------------------------------------
	process(rs0,reg2)
		begin 
		if(rs0=reg2)then
			sinal1 <= '1';
		else
			sinal1 <= '0';
		end if;
	end process;
	-------------------------------------------------------------------
	process(rs0,reg3)
		begin 
		if(rs0=reg3)then
			sinal2 <= '1';
		else
			sinal2 <= '0';
		end if;
	end process;
	-------------------------------------------------------------------
	process(rs1,reg2)
		begin 
		if(rs1=reg2)then
			sinal3 <= '1';
		else
			sinal3 <= '0';
		end if;
	end process;
	-------------------------------------------------------------------
	process(rs1,reg3)
		begin 
		if(rs1=reg3)then
			sinal4 <= '1';
		else
			sinal4 <= '0';
		end if;
	end process;
	-------------------------------------------------------------------
end behavior;