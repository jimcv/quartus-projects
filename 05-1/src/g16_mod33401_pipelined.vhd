--
-- entity name: g16_Hash10
--
-- Version 1.0
-- Authors: Jimmy Sheng, Yongde Yu
-- Date: March 23, 2022
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity g16_mod33401_pipelined is
	Port(	A				:in	std_logic_vector(31 downto 0);
			clk			:in	std_logic;
			reset			:in	std_logic;
			enable		:in	std_logic;
			Amod33401	:out	std_logic_vector(15 downto 0);
			Afloor33401	:out	std_logic_vector(16 downto 0));
end g16_mod33401_pipelined;

architecture arch of g16_mod33401_pipelined is

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
	