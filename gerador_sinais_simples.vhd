LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity gerador_sinais_simples is
port(	opcode : in std_logic_Vector(5 downto 0);
		AdiantaA1,AdiantaB1:out std_logic_vector(1 downto 0)
	 );
end gerador_sinais_simples;

architecture behavior of gerador_sinais_simples is 
begin 



			process(opcode)
			begin	
			------------------------------------------------------
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
								AdiantaB1 <= "00";
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
							AdiantaB1<="00";
				end if;
			end process;
end behavior;