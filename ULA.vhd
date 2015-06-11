Library IEEE;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;
Use ieee.std_logic_arith.all;

Entity ULA is
port (
	in0, in1: in std_logic_vector(31 downto 0);
	oper: in std_logic_vector(2 downto 0);
	zero, over: out std_logic;
	output : out std_logic_vector(31 downto 0)
);
end ULA;

architecture rtl of ULA is
begin
	with oper select
		output <=
			(in0+in1) when "010",
			(in0-in1) when "110",
			(in0 and in1) when "000",
			(in0 or in1) when "001",
			(in0 <= '1') when "111",
			in0 when others;
			
end rtl;	 