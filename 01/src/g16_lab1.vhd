-- author: 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity g16_lab1 is
	Port(	clk			:in	std_logic;
			countbytwo	:in	std_logic;
			rst			:in	std_logic;
			enable		:in	std_logic;
			max_count	:in	std_logic_vector(15 downto 0);
			output		:out	std_logic_vector(15 downto 0));
end g16_lab1;

architecture counter of g16_lab1 is

