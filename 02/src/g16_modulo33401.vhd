--
-- entity name: g16_modulo33401
--
-- Version 1.0
-- Authors: Jimmy Sheng, Yongde Yu
-- Date: March 9, 2022
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity g16_modulo33401 is
	Port(	A				:in	std_logic_vector(31 downto 0);
			Amod33401	:out	std_logic_vector(15 downto 0);
			Afloor33401	:out	std_logic_vector(16 downto 0));
end g16_modulo33401;

architecture arch of g16_modulo33401 is

signal A15:		unsigned(46 downto 0);
signal A4:		unsigned(35 downto 0);
signal A1:		unsigned(32 downto 0);
signal Asum:	unsigned(46 downto 0);

signal A9:		unsigned(40 downto 0);
signal A7:		unsigned(38 downto 0);
signal Atotal:	unsigned(46 downto 0);

begin
	-- compute floor division
	A15		<= SHIFT_LEFT("000000000000000" & UNSIGNED(A), 15);
	A4			<= SHIFT_LEFT("0000" & UNSIGNED(A), 4);
	A1			<= SHIFT_LEFT("0" & UNSIGNED(A), 1);
	Asum		<= A15 + A4 + A1;
	A9			<= SHIFT_LEFT("000000000" & UNSIGNED(A), 9);
	A7			<= SHIFT_LEFT("0000000" & UNSIGNED(A), 7);
	Atotal	<= Asum - A9 - A7;
	Afloor33401 <= STD_LOGIC_VECTOR(SHIFT_RIGHT(Atotal, 30))(16 downto 0);
	
end arch;
	