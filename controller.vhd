LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

ENTITY controller IS
	PORT (
		input : IN std_logic_vector(4 downto 0);
		clk : IN STD_LOGIC;
		rst : IN STD_LOGIC := '0';
		wb : out STD_LOGIC;
		m : out STD_LOGIC;
		ex : out
	);
END controller;

ARCHITECTURE rtl OF controller IS
    TYPE type_fstate IS (s0,s1,s2,s3,s4);
	 
    SIGNAL fstate : type_fstate;
    SIGNAL reg_fstate : type_fstate;
	 
BEGIN
    PROCESS (clk,reg_fstate)
    BEGIN
        IF (clk='1' AND clk'event) THEN
            fstate <= reg_fstate;
        END IF;
    END PROCESS;

    PROCESS (fstate,rst)
    BEGIN
        IF (rst='1') THEN
            reg_fstate <= s0;
        ELSE
            CASE fstate IS
                WHEN s0 =>
                WHEN s1 =>
					 WHEN s2 =>
                WHEN s3 =>
					 WHEN s4 =>
						  
                WHEN OTHERS => 
                    enable <= "00";
                    report "Reach undefined state";
            END CASE;
        END IF;
    END PROCESS;
END rtl;
