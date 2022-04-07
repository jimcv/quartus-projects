-- this circuit implements the complete timestamper function
--
-- entity name: g16_timestamper
--
-- Version 1.0
-- Authors: Jimmy Sheng, YongDe Yu
-- Date: April 7, 2022
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity g16_timestamper is
	Port(	clk, rst, enable		:in	std_logic;
			message					:in	std_logic_vector(31 downto 0);
			timestamp				:in	std_logic_vector(21 downto 0);
			signature				:out	std_logic_vector(15 downto 0);
end g16_timestamper;

architecture arch of g16_timestamper is

begin
	
end arch;

