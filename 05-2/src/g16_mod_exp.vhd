--
-- entity name: g16_mod_exp
-- implements s = c^d modulo 33401
-- 
-- Version 1.0
-- Authors: Jimmy Sheng, YongDe Yu
-- Date: March 23, 2022

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

architecture mod_exp of g16_mod_exp is
-- component
component g16_mod33401_pipelined is
	Port(	A				:in	std_logic_vector(31 downto 0);
			clk			:in	std_logic;
			reset			:in	std_logic;
			enable		:in	std_logic;
			Amod33401	:out	std_logic_vector(15 downto 0);
			Afloor33401	:out	std_logic_vector(16 downto 0));
end component;
component Counter is
	Port(	reset		:in		std_logic;
			start		:in		std_logic;
			clk		:in		std_logic;
			target	:in		std_logic_vector(13 downto 0);
			done		:out		std_logic;
			count		:inout	std_logic_vector(17 downto 0));
end component;
-- signal for modulo block
signal mod_A:			std_logic_vector(31 downto 0);
signal mod_enable:	std_logic;
signal mod_Amod:		std_logic_vector(15 downto 0);
signal mod_Afloor:	std_logic_vector(16 downto 0);
-- signal for counter
signal k:				std_logic_vector(17 downto 0);
signal c_ready:		std_logic;

begin
	-- modulo wiring
	M1: g16_mod33401_pipelined port map (mod_A, clk, reset, mod_enable, mod_Amod, mod_Afloor);
	mod_enable	<= (NOT c_ready) AND (start);
	mod_A			<= STD_LOGIC_VECTOR(RESIZE((UNSIGNED(c) * UNSIGNED(mod_Amod)), 32));
	s				<= mod_Amod;
	-- counter wiring
	C1: Counter port map (reset, start, clk, d, c_ready, k);
	ready	<= c_ready;
end mod_exp;

