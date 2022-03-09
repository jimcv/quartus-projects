-- Authors: Jimmy Sheng, Yongde Yu
-- provide modulo base 33401 of the input (33401 = 127 * 263)
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity g16_modulo33401 is
	Port(	A				:in	std_logic_vector(31 downto 0);
			Amod33401	:out	std_logic_vector(15 downto 0);
			Afloor33401	:out	std_logic_vector(16 downto 0));
end g16_modulo33401;