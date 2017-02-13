LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity geradordesinais is 

	port(
		opcode  : in std_logic_vector(5 downto 0);
		clk,rst : in std_logic;
		sinal1,sinal2,sinal3,sinal4: in std_logic;
		fontepc			: in std_logic;
		AdiantaA,AdiantaB:out std_logic_vector(1 downto 0)
	);
	
end geradordesinais;


architecture behavior of geradordesinais is
signal AdiantaA1,AdiantaB1 : std_logic_vector(1 downto 0);
signal saida2,en0 :std_logic;

component flipflop1b
	port(
		clk, rst : in std_logic;  
		D : in  std_logic;  
		Q : out std_logic
	);  
end component;

component mux2to11bit
	Port (
		SEL : in  STD_logic;
		A, B   : in  STD_logic;
		X   : out STD_LOGIC
	);
end component;

begin
		flip1 : flipflop1b   port map(clk,rst,saida2,en0);
		mux1  : mux2to11bit  port map(fontepc,en0,fontepc,saida2);


		process(opcode,sinal1,sinal2,sinal3,sinal4)
			begin
			------------------------------------------------------
			if(saida2 = '1')then -- desabilita hazard de controle
					if(opcode="000000")then
							AdiantaA1 <= "00";
							AdiantaB1 <= "00";
					elsif(opcode="100011")then --lw
							AdiantaA1 <= "00";
							AdiantaB1 <= "11";
					elsif(opcode="101011")then --sw
							AdiantaA1 <= "00";
							AdiantaB1 <= "11";
					elsif(opcode="000100")then --beq
							AdiantaA1 <= "00";
							AdiantaB1 <= "11";
					elsif(opcode="001000")then --addi
							AdiantaA1<="00";
							AdiantaB1<="11";
					elsif(opcode="001101")then --ori
							AdiantaA1<="00";
							AdiantaB1<="11";
					elsif(opcode="000010")then --jumps
							AdiantaA1<="00";
							AdiantaB1<="11";
					else
						AdiantaA1<="00";
						AdiantaB1<="11";
					end if;
			
			else -- habilitado
				if(opcode="000000") then -- instruçoes tipo R
						if(sinal1='1' and sinal2 ='1')then  
								AdiantaA1 <= "10";
								AdiantaB1 <= "10";
						elsif(sinal1='1' and sinal2='0'and sinal4='0')then
								AdiantaA1 <= "10";
								AdiantaB1 <= "00";
						elsif(sinal2='1' and sinal1='0' and sinal3='0')then
								AdiantaA1 <= "00";
								AdiantaB1 <= "10";
						elsif(sinal1='1' and sinal4='1')then
								AdiantaA1 <= "10";
								AdiantaB1 <= "01";
						elsif(sinal2='1' and sinal3='1')then
								AdiantaA1 <= "01";
								AdiantaB1 <= "10";
						elsif(sinal3='1' and sinal4='1')then
								AdiantaA1 <= "01";
								AdiantaB1 <= "01";
						elsif(sinal3='1' and sinal2='0'and sinal4='0')then
								AdiantaA1 <= "01";
								AdiantaB1 <= "00";
						elsif(sinal4='1' and sinal1='0' and sinal3='0')then
								AdiantaA1 <= "00";
								AdiantaB1 <= "01";
						else
								AdiantaA1 <= "00";
								AdiantaB1 <= "00";	
						end if;
				------------------------------------------------------
				elsif(opcode="100011")then --lw
						if(sinal1='1')then
							AdiantaA1 <= "10";
							AdiantaB1 <= "11";
						elsif(sinal3='1')then
							AdiantaA1 <= "01";
							AdiantaB1 <= "11";
						else
							AdiantaA1 <= "00";
							AdiantaB1 <= "11";
						end if;
				------------------------------------------------------
				elsif(opcode="101011")then --sw
						if(sinal1='1')then
							AdiantaA1 <= "10";
							AdiantaB1 <= "11";
						elsif(sinal3='1')then
							AdiantaA1 <= "01";
							AdiantaB1 <= "11";
						else
							AdiantaA1 <= "00";
							AdiantaB1 <= "11";
					end if;
				------------------------------------------------------
				elsif(opcode="000100")then --beq
						if(sinal1='1')then
							AdiantaA1 <= "10";
							AdiantaB1 <= "11";
						elsif(sinal3='1')then
							AdiantaA1 <= "01";
							AdiantaB1 <= "11";
						else
							AdiantaA1 <= "00";
							AdiantaB1 <= "11";
						end if;
				------------------------------------------------------
				elsif(opcode="001000")then --addi
						if(sinal1='1')then
							AdiantaA1 <= "10";
							AdiantaB1 <= "11";
						elsif(sinal3='1')then
							AdiantaA1 <= "01";
							AdiantaB1 <= "11";
						else
							AdiantaA1<="00";
							AdiantaB1<="11";
						end if;
				------------------------------------------------------
				elsif(opcode="001101")then --ori
						if(sinal1='1')then
							AdiantaA1 <= "10";
							AdiantaB1 <= "11";
						elsif(sinal3='1')then
							AdiantaA1 <= "01";
							AdiantaB1 <= "11";
						else
							AdiantaA1<="00";
							AdiantaB1<="11";
						end if;
				------------------------------------------------------
				elsif(opcode="000010")then --jumps
						AdiantaA1<="00";
						AdiantaB1<="11";
				------------------------------------------------------
				else
						AdiantaA1<="00";
						AdiantaB1<="11";
				end if;
			end if;
		end process;
			
			AdiantaA <= AdiantaA1;
			AdiantaB <= AdiantaB1;

end behavior;