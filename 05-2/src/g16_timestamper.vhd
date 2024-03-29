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
			signature				:out	std_logic_vector(15 downto 0));
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
component State_Counter is
	Port(	reset		:in		std_logic;
			start		:in		std_logic;
			clk		:in		std_logic;
			target	:in		std_logic_vector(1 downto 0);
			done		:out		std_logic;
			count		:inout	std_logic_vector(1 downto 0));
end component;
-- signals
signal hash_enable_2:							std_logic;
signal hash_in_2:									std_logic_vector(31 downto 0);
signal hash_out_1, hash_out_2:				std_logic_vector(9 downto 0);
signal mod_d:										std_logic_vector(13 downto 0);
signal mod_start, mod_ready:					std_logic;
signal mod_s:										std_logic_vector(15 downto 0);
signal storage_reg:								std_logic_vector(15 downto 0);
signal sc_target, sc_count:					std_logic_Vector(1 downto 0);
signal sc_done, sc_enable:						std_logic;

begin
	-- component wiring
	H1: g16_HASH10 port map (clk, rst, enable, message, hash_out_1);
	H2: g16_HASH10 port map (clk, rst, hash_enable_2, hash_in_2, hash_out_2);
	M1: g16_mod_exp port map (mod_d, hash_out_2, mod_start, clk, rst, mod_s, mod_ready);
	SC: State_Counter port map (rst, sc_enable, clk, sc_target, sc_done, sc_count);
	-- concurrent wiring
	hash_in_2 <= hash_out_1 & timestamp;
	mod_d <= STD_LOGIC_VECTOR(TO_UNSIGNED(13205, 14));
	signature <= storage_reg;
	sc_target <= STD_LOGIC_VECTOR(TO_UNSIGNED(2, 2));
	sc_enable <= NOT enable;
	
	process(clk, rst, mod_ready, mod_s)
	begin
		if rst = '1' then
			storage_reg <= STD_LOGIC_VECTOR(TO_UNSIGNED(0, 16));
		elsif rising_edge(clk) then
			if mod_ready = '1' then
				storage_reg	<= mod_s;
			end if;
		end if;
	end process;
	
	process(clk, rst, enable, sc_count)
	begin
		if rst = '1' then
			mod_start <= '0';
			hash_enable_2 <= '0';
		elsif rising_edge(clk) then
			if enable = '1' then
				mod_start <= '0';
				hash_enable_2 <= '0';
			else
				if UNSIGNED(sc_count) = TO_UNSIGNED(1, 2) then
					hash_enable_2 <= '1';
					mod_start <= '0';
				elsif UNSIGNED(sc_count) = TO_UNSIGNED(2, 2) then
					hash_enable_2 <= '0';
					mod_start <= '1';
				end if;
			end if;
		end if;
	end process;
	
end arch;

