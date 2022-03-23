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
signal S1_1:	unsigned(31 downto 0);
signal S1_2:	unsigned(32 downto 0);
signal S2_1:	unsigned(32 downto 0);
signal S2_2:	unsigned(32 downto 0);
signal S3_1:	unsigned(32 downto 0);
signal S3_2:	unsigned(35 downto 0);
signal S4_1:	unsigned(35 downto 0);
signal S4_2:	unsigned(35 downto 0);
signal S5_1:	unsigned(35 downto 0);
signal S5_2:	unsigned(46 downto 0);
signal S6_1:	unsigned(46 downto 0);
signal S6_2:	unsigned(46 downto 0);
signal S7_1:	unsigned(46 downto 0);
signal S7_2:	unsigned(40 downto 0);
signal S8_1:	unsigned(40 downto 0);
signal S8_2:	unsigned(46 downto 0);
signal S9_1:	unsigned(46 downto 0);
signal S9_2:	unsigned(38 downto 0);
signal S10_1:	unsigned(31 downto 0);
signal S10_2:	unsigned(46 downto 0);
signal S11_1:	unsigned(31 downto 0);
signal S11_2:	unsigned(16 downto 0);
signal S12_1: 	unsigned(31 downto 0);
signal S12_2:	unsigned(16 downto 0);
signal S12_3:	unsigned(23 downto 0);
signal S13_1: 	unsigned(31 downto 0);
signal S13_2:	unsigned(16 downto 0);
signal S13_3:	unsigned(23 downto 0);
signal S14_1: 	unsigned(31 downto 0);
signal S14_2:	unsigned(16 downto 0);
signal S14_3:	unsigned(23 downto 0);
signal S14_4:	unsigned(25 downto 0);
signal S15_1: 	unsigned(31 downto 0);
signal S15_2:	unsigned(16 downto 0);
signal S15_3:	unsigned(25 downto 0);
signal S16_1: 	unsigned(31 downto 0);
signal S16_2:	unsigned(16 downto 0);
signal S16_3:	unsigned(25 downto 0);
signal S16_4:	unsigned(31 downto 0);
signal S17_1: 	unsigned(31 downto 0);
signal S17_2:	unsigned(16 downto 0);
signal S17_3:	unsigned(31 downto 0);
signal S18_1: 	unsigned(31 downto 0);
signal S18_2:	unsigned(16 downto 0);
signal S18_3:	unsigned(31 downto 0);
signal S18_4:	unsigned(19 downto 0);
signal S19_1: 	unsigned(31 downto 0);
signal S19_2:	unsigned(16 downto 0);
signal S19_3:	unsigned(31 downto 0);

begin
	process(clk, reset, enable, A)
	begin
		-- async reset
		if reset = '1' then
			S0		<= TO_UNSIGNED(0, 32);
			S1_1	<= TO_UNSIGNED(0, 32);
			S1_2	<= TO_UNSIGNED(0, 33);
			S2_1	<= TO_UNSIGNED(0, 33);
			S2_2	<= TO_UNSIGNED(0, 33);
			S3_1	<= TO_UNSIGNED(0, 33);
			S3_2	<= TO_UNSIGNED(0, 36);
			S4_1	<= TO_UNSIGNED(0, 36);
			S4_2	<= TO_UNSIGNED(0, 36);
			S5_1	<= TO_UNSIGNED(0, 36);
			S5_2	<= TO_UNSIGNED(0, 47);
			S6_1	<= TO_UNSIGNED(0, 47);
			S6_2	<= TO_UNSIGNED(0, 47);
			S7_1	<= TO_UNSIGNED(0, 47);
			S7_2	<= TO_UNSIGNED(0, 41);
			S8_1	<= TO_UNSIGNED(0, 41);
			S8_2	<= TO_UNSIGNED(0, 47);
			S9_1	<= TO_UNSIGNED(0, 47);
			S9_2	<= TO_UNSIGNED(0, 39);
			S10_1	<= TO_UNSIGNED(0, 32);
			S10_2	<= TO_UNSIGNED(0, 47);
			S11_1	<= TO_UNSIGNED(0, 32);
			S11_2	<= TO_UNSIGNED(0, 17);
			S12_1	<= TO_UNSIGNED(0, 32);
			S12_2	<= TO_UNSIGNED(0, 17);
			S12_3	<= TO_UNSIGNED(0, 24);
			S13_1	<= TO_UNSIGNED(0, 32);
			S13_2	<= TO_UNSIGNED(0, 17);
			S13_3	<= TO_UNSIGNED(0, 24);
			S14_1	<= TO_UNSIGNED(0, 32);
			S14_2	<= TO_UNSIGNED(0, 17);
			S14_3	<= TO_UNSIGNED(0, 24);
			S14_4	<= TO_UNSIGNED(0, 26);
			S15_1	<= TO_UNSIGNED(0, 32);
			S15_2	<= TO_UNSIGNED(0, 17);
			S15_3	<= TO_UNSIGNED(0, 26);
			S16_1	<= TO_UNSIGNED(0, 32);
			S16_2	<= TO_UNSIGNED(0, 17);
			S16_3	<= TO_UNSIGNED(0, 26);
			S16_4	<= TO_UNSIGNED(0, 32);
			S17_1	<= TO_UNSIGNED(0, 32);
			S17_2	<= TO_UNSIGNED(0, 17);
			S17_3	<= TO_UNSIGNED(0, 32);
			S18_1	<= TO_UNSIGNED(0, 32);
			S18_2	<= TO_UNSIGNED(0, 17);
			S18_3	<= TO_UNSIGNED(0, 32);
			S18_4	<= TO_UNSIGNED(0, 20);
			S19_1	<= TO_UNSIGNED(0, 32);
			S19_2	<= TO_UNSIGNED(0, 17);
			S19_3	<= TO_UNSIGNED(0, 32);
			Amod33401	<= STD_LOGIC_VECTOR(TO_UNSIGNED(1, 16));
			Afloor33401	<=	STD_LOGIC_VECTOR(TO_UNSIGNED(0, 17));
		elsif enable = '1' then
			if rising_edge(clk) then
				-- stage 0
				S0		<= UNSIGNED(A);
				-- stage 1 (shift, A1)
				S1_1	<= S0;
				S1_2	<= SHIFT_LEFT("0" & S0, 1);
				-- stage 2 (add)
				S2_1	<= S1_2;
				S2_2	<= S1_1 + S1_2;
				-- stage 3 (shift, A4)
				S3_1	<= S2_2;
				S3_2	<= SHIFT_LEFT("000" & S2_1, 3);
				-- stage 4 (add)
				S4_1	<= S3_2;
				S4_2	<= S3_1 + S3_2;
				-- stage 5 (shift, A15)
				S5_1	<= S4_2;
				S5_2	<= SHIFT_LEFT("00000000000" & S4_1, 11);
				-- stage 6 (add, Asum)
				S6_1	<= S5_2;
				S6_2	<= S5_1 + S5_2;
				-- stage 7 (shift, A9)
				S7_1	<= S6_2;
				S7_2	<= RESIZE(SHIFT_RIGHT(S6_1, 6), 41);
				-- stage 8 (sub)
				S8_1	<= S7_2;
				S8_2	<= S7_1 - S7_2;
				-- stage 9 (shift, A7)
				S9_1	<= S8_2;
				S9_2	<= RESIZE(SHIFT_RIGHT(S8_1, 2), 39);
				-- stage 10 (sub, Atotal, keep A)
				S10_1	<= RESIZE(SHIFT_RIGHT(S9_2, 7), 32);
				S10_2	<= S9_1 - S9_2;
				-- stage 11 (A, Afloor33401)
				S11_1	<= S10_1;
				S11_2	<= RESIZE(SHIFT_RIGHT(S10_2, 30), 17);
				-- compute product
				-- stage 12 (shift, B7)
				S12_1	<= S11_1;
				S12_2	<= S11_2;
				S12_3	<= SHIFT_LEFT("0000000" & S11_2, 7);
				-- stage 13 (add)
				S13_1	<= S12_1;
				S13_2	<= S12_2;
				S13_3	<= S12_2 + S12_3;
				-- stage 14 (shift, B9)
				S14_1	<= S13_1;
				S14_2	<= S13_2;
				S14_3	<= S13_3;
				S14_4	<=	SHIFT_LEFT("000000000" & S13_2, 9);
				-- stage 15 (add)
				S15_1	<= S14_1;
				S15_2	<= S14_2;
				S15_3	<= S14_3 + S14_4;
				-- stage 16 (shift, B15)
				S16_1	<= S15_1;
				S16_2	<= S15_2;
				S16_3	<= S15_3;
				S16_4	<= SHIFT_LEFT("000000000000000" & S15_2, 15);
				-- stage 17 (add)
				S17_1	<= S16_1;
				S17_2	<= S16_2;
				S17_3	<= S16_3 + S16_4;
				-- stage 18 (shift, B3)
				S18_1	<= S17_1;
				S18_2	<= S17_2;
				S18_3	<= S17_3;
				S18_4	<= SHIFT_LEFT("000" & S17_2, 3);
				-- stage 19 (sub, Btotal)
				S19_1	<= S18_1;
				S19_2	<= S18_2;
				S19_3	<= S18_3 - S18_4;
				-- stage 20 (sub)
				Amod33401	<= STD_LOGIC_VECTOR(RESIZE(S19_1 - S19_3, 16));
				Afloor33401	<=	STD_LOGIC_VECTOR(S19_2);
			end if;
		end if;
	end process;
	
end arch;
	