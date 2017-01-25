LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity geradordesinais is 

	port(
		opcode : in std_logic_vector(5 downto 0);
		sinal1,sinal2,sinal3,sinal4: in std_logic;
		AdiantaA,AdiantaB:out std_logic_vector(1 downto 0)
	);
	
end geradordesinais;


architecture behavior of geradordesinais is
signal AdiantaA1,AdiantaB1 : std_logic_vector(1 downto 0);
begin
		process(opcode,sinal1,sinal2,sinal3,sinal4)
	begin
		if(opcode="000000") then
			if(sinal1='1' and sinal2 ='1')then -- reg2 = rs0 
					AdiantaA1 <= "10";
					AdiantaB1 <= "10";
			elsif(sinal3='1' and sinal4 ='1')then
					AdiantaA1 <= "01";
					AdiantaB1 <= "01";
			elsif(sinal1='1' and sinal4='1')then
					AdiantaA1 <= "10";
					AdiantaB1 <= "01";
			elsif(sinal2 ='1' and sinal3 = '1')then
					AdiantaA1 <="01";
					AdiantaB1 <="10";
			elsif(sinal1='1' and sinal2='0' and sinal3='0' and sinal4='0')then
					AdiantaA1 <= "10";
					AdiantaB1 <= "00";
			elsif(sinal1='0' and sinal2='1' and sinal3='0' and sinal4='0')then
					AdiantaA1 <= "00";
					AdiantaB1 <= "10";
			elsif(sinal1='0' and sinal2='0' and sinal3='1' and sinal4='0')then
					AdiantaA1 <= "01";
					AdiantaB1 <= "00";
			elsif(sinal1='0' and sinal2='0' and sinal3='0' and sinal4='1')then
					AdiantaA1 <= "00";
					AdiantaB1 <= "01";
			end if;
		elsif(opcode="100011")then --lw
			if(sinal1='0' and sinal3='0')then
				AdiantaA1 <= "00";
				AdiantaB1 <= "11";
			elsif(sinal1='1')then
				AdiantaA1 <= "10";
				AdiantaB1 <= "11";
			elsif(sinal3='1')then
				AdiantaA1<="01";
				AdiantaB1<="11";
			end if;
		elsif(opcode="101011")then --sw
			if(sinal1='0' and sinal3='0')then
				AdiantaA1 <= "00";
				AdiantaB1 <= "11";
			elsif(sinal1='1')then
				AdiantaA1 <= "10";
				AdiantaB1 <= "11";
			elsif(sinal3='1')then
				AdiantaA1<="01";
				AdiantaB1<="11";
			end if;
		elsif(opcode="000100")then --beq
			if(sinal1='0' and sinal3='0')then
				AdiantaA1 <= "00";
				AdiantaB1 <= "11";
			elsif(sinal1='1')then
				AdiantaA1 <= "10";
				AdiantaB1 <= "11";
			elsif(sinal3='1')then
				AdiantaA1<="01";
				AdiantaB1<="11";
			end if;
		elsif(opcode="001000")then --addi
			if(sinal1='0' and sinal3='0')then
				AdiantaA1 <= "00";
				AdiantaB1 <= "11";
			elsif(sinal1='1')then
				AdiantaA1 <= "10";
				AdiantaB1 <= "11";
			elsif(sinal3='1')then
				AdiantaA1<="01";
				AdiantaB1<="11";
			end if;
		elsif(opcode="001101")then --ori
			if(sinal1='0' and sinal3='0')then
				AdiantaA1 <= "00";
				AdiantaB1 <= "11";
			elsif(sinal1='1')then
				AdiantaA1 <= "10";
				AdiantaB1 <= "11";
			elsif(sinal3='1')then
				AdiantaA1<="01";
				AdiantaB1<="11";
			end if;
		elsif(opcode="000010")then --jumps
			AdiantaA1<="00";
			AdiantaB1<="11";
		else
			AdiantaA1<="00";
			AdiantaB1<="11";
		end if;
	end process;
	
	AdiantaA <= AdiantaA1;
	AdiantaB <= AdiantaB1;

end behavior;