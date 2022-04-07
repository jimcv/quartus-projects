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
-- components
component g16_HASH10 is
	Port(	clk, rst, enable			:in	std_logic;
			message						:in	std_logic_vector(31 downto 0);
			hash10						:out	std_logic_vector(9 downto 0));
end component;
component g16_mod_exp is
	Port(	d				:in	std_logic_vector(13 downto 0);
			c				:in	std_logic_vector(9 downto 0);
			start			:in	std_logic;
			clk			:in	std_logic;
			reset			:in	std_logic;
			s				:out	std_logic_vector(15 downto 0);
			ready			:out	std_logic);
end component;

begin
	
end arch;

