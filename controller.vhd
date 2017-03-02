LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

ENTITY controller IS
	PORT (
		clk : in std_logic;
		rst	: in std_logic;
		opcode : IN std_logic_vector(5 downto 0);
		ulaOp : out std_logic_vector(1 downto 0);
		RegDst, escMem, lerMem, DvC, memParaReg, escReg: out std_logic;
		reg1,reg2,reg3 : in std_logic_vector(4 downto 0);
		fontepc			: in std_logic;  -- adicionado do mips_dinamico 
		ehbeqadiantado : out std_logic; -- adicionado do mips_dinamico
		adiantaA,adiantaB :out std_logic_vector(1 downto 0)
	);
END controller;

ARCHITECTURE rtl OF controller IS	 
signal sig_eh_beq_adiantado : std_logic; -- se estiver ligado o beq sempre pulando estara em =1 
signal DVC_1 : std_logic;
----------------------------------------------------------
signal combination0,combination1 : std_logic_vector(1 downto 0);
signal sinal11,sinal22,sinal33,sinal44 : std_logic;
-- REG SOURCE
-- REG2 ->
-- REG3 ->
-- sinal1 = true , reg2 = rs0
-- sinal2 = true , reg3 = rs0
-- sinal3 = true , reg2 = rs1
-- sinal4 = true , reg3 = rs1
signal saidamuxes:std_logic_vector(4 downto 0);
signal sel :std_logic;
---------------------------------------------------------
component mux2to1 -- comparador decide de onde vem o registrador destino , se de uma parte do imediato ou reg 2
		generic(
			DATA_WIDTH : natural := 32
		);
		port (
			SEL : in  STD_LOGIC;
			A, B   : in  STD_LOGIC_VECTOR((DATA_WIDTH-1) downto 0);
			X   : out STD_LOGIC_VECTOR((DATA_WIDTH-1) downto 0)
		);
	end component;
---------------------------------------------------------
COMPONENT comparador  
	port(
		  clk : in std_logic;
		  rst:in std_logic;	
		  reg1,reg2,reg3 : in std_logic_vector(4 downto 0);
		  sinal1,sinal2,sinal3,sinal4: out std_logic	
	);
	
end COMPONENT;
-----------------------------------------------------------
component geradordesinais
	port(
		opcode : in std_logic_vector(5 downto 0);
		clk,rst : in std_logic;
		sinal1,sinal2,sinal3,sinal4: in std_logic;
		AdiantaA,AdiantaB:out std_logic_vector(1 downto 0)
	);
end component;
-----------------------------------------------------------
component controle_beq
	port( clk 	   		: in  std_logic;
			rst				: in  std_logic;
			DVC 				: in  std_logic;
			FontePc			: in  std_logic;
			ehbeqadiantado : out std_logic
		);
end component;
-----------------------------------------------------------
BEGIN
-----------------------------------------------------------
	controle_de_beq : controle_beq port map(clk,rst,DVC_1,fontepc,sig_eh_beq_adiantado);	
   ehbeqadiantado <= sig_eh_beq_adiantado;
-----------------------------------------------------------	
	igualitario: comparador port map(
		clk=>clk,
		rst=>rst,
		reg1=>saidamuxes,
		reg2=>reg2,
		reg3=>reg3,
--		reg1=>reg1,
--		reg2=>reg2,
--		reg3=>reg3,
		sinal1 => sinal11,
		sinal2 => sinal22,
		sinal3 => sinal33,
		sinal4 => sinal44
	);
-----------------------------------------------------------
	gerador: geradordesinais port map(
		opcode  => opcode,
		clk	  => clk,
		rst     => rst,
		sinal1  => sinal11,
		sinal2  => sinal22,
		sinal3  => sinal33,
		sinal4  => sinal44,
		AdiantaA => AdiantaA,
		AdiantaB => AdiantaB
	);
-----------------------------------------------------------	
	mux_register_destino: mux2to1 GENERIC MAP (DATA_WIDTH => 5) PORT MAP (
		sel => sel, -- modificado
		A =>  reg3,  -- somente ori , addi, 
		B =>  reg1,  -- operacoes tipo R
		X =>  saidamuxes
	);
-----------------------------------------------------------
	process(opcode)
	begin
		CASE opcode IS
			WHEN "000000" => -- R type
				RegDst <= '1';
				sel<='1';
				memParaReg <= '0';
				lerMem <= '0';
				escMem <= '0';
				escReg <= '1';
				DvC <= '0';
				DVC_1 <='0';
				ulaOp <= "10";
			WHEN "100011" => -- lw / I type
				RegDst <= '0';
				sel<='0';
				memParaReg <= '1';
				lerMem <= '1';
				escMem <= '0';
				escReg <= '1';
				DvC <= '0';
				DVC_1 <='0';
				ulaOp <= "00";
			WHEN "101011" => -- sw / I type
				RegDst <= '-';
				sel<='-';
				memParaReg <= '-';
				lerMem <= '0';
				escMem <= '1';
				escReg <= '0';
				DvC <= '0';
				DVC_1 <='0';
				ulaOp <= "00";
			WHEN "000100" => -- beq / I type
				RegDst <= '-';
				sel<='-';
				memParaReg <= '-';
				lerMem <= '0';
				escMem <= '0';
				escReg <= '0';
				DvC <= '1';
				DVC_1 <='1';
				ulaOp <= "01";
			WHEN "001000" => -- addi / I type
				RegDst <= '0';
				sel<='0';
				memParaReg <= '0';
				lerMem <= '0';
				escMem <= '0';
				escReg <= '1';
				DvC <= '0';
				DVC_1 <='0';
				ulaOp <= "00";
			WHEN "001101" => -- ori / I type
				RegDst <= '0';
				sel<='0';
				memParaReg <= '0';
				lerMem <= '0';
				escMem <= '0';
				escReg <= '1';
				DvC <= '0';
				DVC_1 <='0';
				ulaOp <= "00";
			WHEN "000010" => -- j / J type
				RegDst <= '-';
				sel<='-';
				memParaReg <= '-';
				lerMem <= '0';
				escMem <= '0';
				escReg <= '0';
				DvC <= '0';
				DVC_1 <='0';
				ulaOp <= "00";
			WHEN OTHERS => --instruçoes nao contabilizadas
				RegDst <= '0';
				sel<='0';
				memParaReg <= '0';
				lerMem <= '0';
				escMem <= '0';
				escReg <= '0';
				DvC <= '0';
				DVC_1 <='0';
				ulaOp <= "00";
		END CASE;
	end process;
-------------------------------------------------------------------
END rtl;
