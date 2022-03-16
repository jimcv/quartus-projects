--
-- entity name: g16_mod_exp
-- implements s = c^d modulo 33401
-- 
-- Version 1.0
-- Authors: Jimmy Sheng, YongDe Yu
-- Date: March 16, 2022

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity g16_mod_exp is
	Port(	d				:in	std_logic_vector(13 downto 0);
			c				:in	std_logic_vector(9 downto 0);
			start			:in	std_logic;
			clk			:in	std_logic;
			reset			:in	std_logic;
			s				:out	std_logic_vector(15 downto 0);
			ready			:out	std_logic);
end g16_mod_exp;

architecture arch of g16_mod_exp is
-- component
component g16_modulo33401 is
	Port(	A				:in	std_logic_vector(31 downto 0);
			Amod33401	:out	std_logic_vector(15 downto 0);
			Afloor33401	:out	std_logic_vector(16 downto 0));
end component;
-- signal
signal mod_A:			std_logic_vector(31 downto 0);
signal mod_Amod:		std_logic_vector(15 downto 0);
signal mod_Afloor:	std_logic_vector(16 downto 0);

begin
	-- component mapping
	M1: g16_modulo33401 port map (mod_A, mod_Amod, mod_Afloor);

end arch;

