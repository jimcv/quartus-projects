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
			clk			:in	std_logic;
			reset			:in	std_logic;
			enable		:in	std_logic;
			Amod33401	:out	std_logic_vector(15 downto 0);
			Afloor33401	:out	std_logic_vector(16 downto 0));
end g16_mod33401_pipelined;

architecture arch of g16_mod33401_pipelined is
-- stage signals
signal S0:		unsigned(31 downto 0);
signal S1_A:	unsigned(31 downto 0);
signal S1_A1:	unsigned(32 downto 0);
signal S1_A4:	unsigned(35 downto 0);
signal S1_A15:	unsigned(46 downto 0);
signal S1_A9:	unsigned(40 downto 0);
signal S1_A7:	unsigned(38 downto 0);
signal S2_A:	unsigned(31 downto 0);
signal S2_A15A4:	unsigned(46 downto 0);
-- 1 bit overflow
signal S2_A1A:		unsigned(33 downto 0);
-- 1 bit overflow
signal S2_A9A7:	unsigned(41 downto 0);
signal S3_A:		unsigned(31 downto 0);
signal S3_Asum:	unsigned(46 downto 0);
signal S3_A9A7:	unsigned(41 downto 0);
signal S4_A:		unsigned(31 downto 0);
signal S4_Atot:	unsigned(46 downto 0);
signal S5_A:		unsigned(31 downto 0);
signal S5_Aflo:	unsigned(16 downto 0);
signal S6_A:		unsigned(31 downto 0);
signal S6_Aflo:	unsigned(16 downto 0);
signal S6_B7:		unsigned(23 downto 0);
signal S6_B9:		unsigned(25 downto 0);
signal S6_B15:		unsigned(31 downto 0);
signal S6_B3:		unsigned(19 downto 0);
signal S7_A:		unsigned(31 downto 0);
signal S7_Aflo:	unsigned(16 downto 0);
signal S7_B15B9:	unsigned(31 downto 0);
-- 1 bit overflow
signal S7_B7Aflo:	unsigned(24 downto 0);
signal S7_B3:		unsigned(19 downto 0);
signal S8_A:		unsigned(31 downto 0);
signal S8_Aflo:	unsigned(16 downto 0);
signal S8_Bsum:	unsigned(31 downto 0);
signal S8_B3:		unsigned(19 downto 0);
signal S9_A:		unsigned(31 downto 0);
signal S9_Aflo:	unsigned(16 downto 0);
signal S9_Btot:	unsigned(31 downto 0);

begin
	process(clk, reset, enable, A)
	begin
		-- async reset
		if reset = '1' then
			S0		<= TO_UNSIGNED(0, 32);
			-- TODO
			Amod33401	<= STD_LOGIC_VECTOR(TO_UNSIGNED(1, 16));
			Afloor33401	<=	STD_LOGIC_VECTOR(TO_UNSIGNED(0, 17));
		elsif enable = '1' then
			if rising_edge(clk) then
				-- stage 0
				S0		<= UNSIGNED(A);
				-- stage 1 (shifting)
				S1_A		<= S0;
				S1_A1		<= SHIFT_LEFT("0" & S0, 1);
				S1_A4		<= SHIFT_LEFT("0000" & S0, 4);
				S1_A15	<= SHIFT_LEFT("000000000000000" & S0, 15);
				S1_A9		<= SHIFT_LEFT("000000000" & S0, 9);
				S1_A7		<= SHIFT_LEFT("0000000" & S0, 7);
				-- stage 2 (partial sums)
				S2_A		<= S1_A;
				S2_A15A4	<= S1_A15 + S1_A4;
				S2_A1A	<= S1_A1 + S1_A;
				-- A9A7 needs an extra bit for overflow
				S2_A9A7	<= S1_A9 + S1_A7;
				-- stage 3 (partial sums)
				S3_A		<= S2_A;
				S3_Asum	<= S2_A15A4 + S2_A1A;
				S3_A9A7	<= S2_A9A7;
				-- stage 4 (obtain Atotal)
				S4_A		<= S3_A;
				S4_Atot	<= S3_Asum - S3_A9A7;
				-- stage 5 (truncate Atotal to obtain Afloor)
				S5_A		<= S4_A;
				S5_Aflo	<= RESIZE(SHIFT_RIGHT(S4_Atot, 30), 17);
				-- stage 6 (shifting)
				S6_A		<= S5_A;
				S6_Aflo	<= S5_Aflo;
				S6_B7		<= SHIFT_LEFT("0000000" & S5_Aflo, 7);
				S6_B9		<= SHIFT_LEFT("000000000" & S5_Aflo, 9);
				S6_B15	<= SHIFT_LEFT("000000000000000" & S5_Aflo, 15);
				S6_B3		<= SHIFT_LEFT("000" & S5_Aflo, 3);
				-- stage 7 (partial sums)
				S7_A		<= S6_A;
				S7_Aflo	<= S6_Aflo;
				S7_B15B9	<= S6_B15 + S6_B9;
				S7_B7Aflo	<= S6_B7 + S6_Aflo;
				S7_B3		<= S6_B3;
				-- stage 8 (partial sums)
				S8_A		<= S7_A;
				S8_Aflo	<= S7_Aflo;
				S8_Bsum	<= S7_B15B9 + S7_B7Aflo;
				S8_B3		<= S7_B3;
				-- stage 9 (obtain Btotal)
				S9_A		<= S8_A;
				S9_Aflo	<= S8_Aflo;
				S9_Btot	<= S8_Bsum - S8_B3;
				-- stage 10 (outputs)
				Amod33401	<= STD_LOGIC_VECTOR(RESIZE(S9_A - S9_Btot, 16));
				Afloor33401	<=	STD_LOGIC_VECTOR(S9_Aflo);
			end if;
		end if;
	end process;
	
end arch;
	