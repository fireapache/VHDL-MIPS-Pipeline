LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

ENTITY controller IS
	PORT (
		opcode : IN std_logic_vector(5 downto 0);
		ulaOp : out std_logic_vector(1 downto 0);
		RegDst, escMem, lerMem, DvC, memParaReg, escReg: out std_logic;
		reg1,reg2,reg3 : in std_logic_vector(4 downto 0);
	   adiantaA,adiantaB :out std_logic_vector(1 downto 0)
	);
END controller;

ARCHITECTURE rtl OF controller IS	 
signal combination0,combination1 : std_logic_vector(1 downto 0);

-- REG SOURCE
-- REG2 ->
-- REG3 ->
-- sinal1 = true , reg2 = rs0
-- sinal2 = true , reg3 = rs0
-- sinal3 = true , reg2 = rs1
-- sinal4 = true , reg3 = rs1

COMPONENT comparador  
	port(
		  clk : in std_logic;
		  rst:in std_logic;	
		  reg1,reg2,reg3 : in std_logic_vector(4 downto 0);
		  sinal1,sinal2,sinal3,sinal4: out std_logic	
	);
	
end COMPONENT;

component geradordesinais
	port(
		opcode : in std_logic_vector(5 downto 0);
		sinal1,sinal2,sinal3,sinal4: in std_logic;
		AdiantaA,AdiantaB:out std_logic_vector(1 downto 0)
	);
end component;

BEGIN
	process(opcode)
	begin
		CASE opcode IS
			WHEN "000000" => -- R type
				RegDst <= '1';
				memParaReg <= '0';
				lerMem <= '0';
				escMem <= '0';
				escReg <= '1';
				DvC <= '0';
				ulaOp <= "10";
			WHEN "100011" => -- lw / I type
				RegDst <= '0';
				memParaReg <= '1';
				lerMem <= '1';
				escMem <= '0';
				escReg <= '1';
				DvC <= '0';
				ulaOp <= "00";
			WHEN "101011" => -- sw / I type
				RegDst <= '-';
				memParaReg <= '-';
				lerMem <= '0';
				escMem <= '1';
				escReg <= '0';
				DvC <= '0';
				ulaOp <= "00";
			WHEN "000100" => -- beq / I type
				RegDst <= '-';
				memParaReg <= '-';
				lerMem <= '0';
				escMem <= '0';
				escReg <= '0';
				DvC <= '1';
				ulaOp <= "01";
			WHEN "001000" => -- addi / I type
				RegDst <= '0';
				memParaReg <= '0';
				lerMem <= '0';
				escMem <= '0';
				escReg <= '1';
				DvC <= '0';
				ulaOp <= "00";
			WHEN "001101" => -- ori / I type
				RegDst <= '0';
				memParaReg <= '0';
				lerMem <= '0';
				escMem <= '0';
				escReg <= '1';
				DvC <= '0';
				ulaOp <= "00";
			WHEN "000010" => -- j / J type
				RegDst <= '-';
				memParaReg <= '-';
				lerMem <= '0';
				escMem <= '0';
				escReg <= '0';
				DvC <= '0';
				ulaOp <= "00";
			WHEN OTHERS => --instruçoes nao contabilizadas
				RegDst <= '0';
				memParaReg <= '0';
				lerMem <= '0';
				escMem <= '0';
				escReg <= '0';
				DvC <= '0';
				ulaOp <= "00";
		END CASE;
	end process;
	-------------------------------------------------------------------
END rtl;
