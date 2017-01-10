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

begin
		process(opcode,sinal1,sinal2,sinal3,sinal4)
	begin
		if(opcode="000000") then
			if(sinal1='1' and sinal2 ='1')then -- reg2 = rs0 
					AdiantaA <= "10";
					AdiantaB <= "10";
			elsif(sinal3='1' and sinal4 ='1')then
					AdiantaA <= "01";
					AdiantaB <= "01";
			elsif(sinal1='1' and sinal4='1')then
					AdiantaA <= "10";
					AdiantaB <= "01";
			elsif(sinal2 ='1' and sinal3 = '1')then
					AdiantaA <="01";
					AdiantaB <="10";
			elsif(sinal1='1' and sinal2='0' and sinal3='0' and sinal4='0')then
					AdiantaA <= "10";
					AdiantaB <= "00";
			elsif(sinal1='0' and sinal2='1' and sinal3='0' and sinal4='0')then
					AdiantaA <= "00";
					AdiantaB <= "10";
			elsif(sinal1='0' and sinal2='0' and sinal3='1' and sinal4='0')then
					AdiantaA <= "01";
					AdiantaB <= "00";
			elsif(sinal1='0' and sinal2='0' and sinal3='0' and sinal4='1')then
					AdiantaA <= "00";
					AdiantaB <= "01";
			end if;
		elsif(opcode="100011")then --lw
			if(sinal1='0' and sinal3='0')then
				AdiantaA <= "00";
				AdiantaB <= "11";
			elsif(sinal1='1')then
				AdiantaA <= "10";
				AdiantaB <= "11";
			elsif(sinal3='1')then
				AdiantaA<="01";
				AdiantaB<="11";
			end if;
		elsif(opcode="101011")then --sw
			if(sinal1='0' and sinal3='0')then
				AdiantaA <= "00";
				AdiantaB <= "11";
			elsif(sinal1='1')then
				AdiantaA <= "10";
				AdiantaB <= "11";
			elsif(sinal3='1')then
				AdiantaA<="01";
				AdiantaB<="11";
			end if;
		elsif(opcode="000100")then --beq
			if(sinal1='0' and sinal3='0')then
				AdiantaA <= "00";
				AdiantaB <= "11";
			elsif(sinal1='1')then
				AdiantaA <= "10";
				AdiantaB <= "11";
			elsif(sinal3='1')then
				AdiantaA<="01";
				AdiantaB<="11";
			end if;
		elsif(opcode="001000")then --addi
			if(sinal1='0' and sinal3='0')then
				AdiantaA <= "00";
				AdiantaB <= "11";
			elsif(sinal1='1')then
				AdiantaA <= "10";
				AdiantaB <= "11";
			elsif(sinal3='1')then
				AdiantaA<="01";
				AdiantaB<="11";
			end if;
		elsif(opcode="001101")then --ori
			if(sinal1='0' and sinal3='0')then
				AdiantaA <= "00";
				AdiantaB <= "11";
			elsif(sinal1='1')then
				AdiantaA <= "10";
				AdiantaB <= "11";
			elsif(sinal3='1')then
				AdiantaA<="01";
				AdiantaB<="11";
			end if;
		elsif(opcode="000010")then --jumps
			AdiantaA<="00";
			AdiantaB<="11";
		else
			AdiantaA<="00";
			AdiantaB<="11";
		end if;
	end process;


end behavior;
