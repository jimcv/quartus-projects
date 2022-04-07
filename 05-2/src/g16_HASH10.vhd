-- this circuit implements a simple 10 bit Hash function
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

signal oldHash:		unsigned(31 downto 0);
signal hash32:			unsigned(31 downto 0);

begin
	process(clk, rst, enable, message)
	begin
		-- async reset
		if rst = '1' then
			oldHash			<= TO_UNSIGNED(5381, 32);
			hash32			<= TO_UNSIGNED(0, 32);
		elsif enable = '1' then
			if rising_edge(clk) then
				hash32	<= SHIFT_LEFT(oldHash, 5) + oldHash + UNSIGNED(message);
				oldHash	<= SHIFT_LEFT(oldHash, 5) + oldHash + UNSIGNED(message);
			end if;
		end if;
	end process;
	
	hash10	<= STD_LOGIC_VECTOR(hash32(31 downto 22) XOR hash32(9 downto 0));
	
end arch;