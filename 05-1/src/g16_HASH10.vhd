--
-- entity name: g16_HASH10
--
-- Version 1.0
-- Authors: Jimmy Sheng, Yongde Yu
-- Date: April 7, 2022
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity g16_HASH10 is
	Port(	clk, rst, enable			:in	std_logic;
			message						:in	std_logic_vector(31 downto 0);
			hash10						:out	std_logic_vector(9 downto 0));
end g16_HASH10;

architecture arch of g16_HASH10 is

begin
	process(clk, reset, enable, A)
	begin
		-- async reset
		elsif enable = '1' then
			if rising_edge(clk) then
			
			end if;
		end if;
	end process;
	
end arch;