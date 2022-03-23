--
-- entity name: g16_mod33401_pipelined
--
-- Version 1.0
-- Authors: Jimmy Sheng, Yongde Yu
-- Date: March 23, 2022
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity g16_mod33401_pipelined is
	Port(	A				:in	std_logic_vector(31 downto 0);
			Amod33401	:out	std_logic_vector(15 downto 0);
			Afloor33401	:out	std_logic_vector(16 downto 0));
end g16_mod33401_pipelined;

architecture arch of g16_mod33401_pipelined is

signal A15:		unsigned(46 downto 0);
signal A4:		unsigned(35 downto 0);
signal A1:		unsigned(32 downto 0);
signal Asum:	unsigned(46 downto 0);
signal A9:		unsigned(40 downto 0);
signal A7:		unsigned(38 downto 0);
signal Atotal:	unsigned(46 downto 0);

signal Afloor:	unsigned(16 downto 0);

signal B15:		unsigned(31 downto 0);
signal B9:		unsigned(25 downto 0);
signal B7:		unsigned(23 downto 0);
signal Bsum:	unsigned(31 downto 0);
signal B3:		unsigned(19 downto 0);
signal Btotal:	unsigned(31 downto 0);

signal Aunsigned:	unsigned(15 downto 0);

begin
	-- compute floor division
	A15		<= SHIFT_LEFT("000000000000000" & UNSIGNED(A), 15);
	A4			<= SHIFT_LEFT("0000" & UNSIGNED(A), 4);
	A1			<= SHIFT_LEFT("0" & UNSIGNED(A), 1);
	Asum		<= A15 + A4 + A1 + UNSIGNED(A);
	A9			<= SHIFT_LEFT("000000000" & UNSIGNED(A), 9);
	A7			<= SHIFT_LEFT("0000000" & UNSIGNED(A), 7);
	Atotal	<= Asum - A9 - A7;
	Afloor	<= SHIFT_RIGHT(Atotal, 30)(16 downto 0);
	Afloor33401 <= STD_LOGIC_VECTOR(Afloor);
	-- compute product
	B15		<= SHIFT_LEFT("000000000000000" & Afloor, 15);
	B9			<= SHIFT_LEFT("000000000" & Afloor, 9);
	B7			<= SHIFT_LEFT("0000000" & Afloor, 7);
	Bsum		<= B15 + B9 + B7 + Afloor;
	B3			<= SHIFT_LEFT("000" & Afloor, 3);
	Btotal	<= Bsum - B3;
	-- subtract
	Aunsigned	<= RESIZE(UNSIGNED(A) - Btotal, 16);
	Amod33401	<= STD_LOGIC_VECTOR(Aunsigned);
end arch;
	