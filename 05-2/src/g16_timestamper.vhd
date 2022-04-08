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
signal hash_enable_1, hash_enable_2:		std_logic;
signal hash_in_2:									std_logic_vector(31 downto 0);
signal hash_out_1, hash_out_2:				std_logic_vector(9 downto 0);
signal mod_d:										std_logic_vector(13 downto 0);
signal mod_start, mod_ready, mod_rst:		std_logic;
signal mod_s:										std_logic_vector(15 downto 0);
signal storage_reg:								std_logic_vector(15 downto 0);
signal sc_target, sc_count:					std_logic_Vector(1 downto 0);
signal sc_done:									std_logic;

begin
	-- component wiring
	H1: g16_HASH10 port map (clk, rst, hash_enable_1, message, hash_out_1);
	H2: g16_HASH10 port map (clk, rst, hash_enable_2, hash_in_2, hash_out_2);
	M1: g16_mod_exp port map (mod_d, hash_out_2, mod_start, clk, mod_rst, mod_s, mod_ready);
	SC: State_Counter port map (rst, enable, clk, sc_target, sc_done, sc_count);
	-- concurrent wiring
	hash_in_2 <= hash_out_1 & timestamp;
	mod_d <= STD_LOGIC_VECTOR(TO_UNSIGNED(13205, 14));
	signature <= storage_reg;
	sc_target <= STD_LOGIC_VECTOR(TO_UNSIGNED(2, 2));
	
	process(clk, rst, mod_ready)
	begin
		-- async reset
		if rst = '1' then
			storage_reg <= STD_LOGIC_VECTOR(TO_UNSIGNED(0, 16));
			mod_rst <= 1;
			-- TODO
		-- if enabled
		elsif mod_ready = '1' then
			if rising_edge(clk) then
				storage_reg <= mod_s;
			end if;
		end if;
	end process;
	
	process(clk, enable, sc_count, mod_start, mod_ready)
	begin
		if rising_edge(clk) then
			if UNSIGNED(sc_count) = TO_UNSIGNED(0, 2) then
				hash_enable_2	<= 0;
				mod_start		<= 0;
				if enable = '1' then
					hash_enable_1 <= 1;
				else
					hash_enable_1 <= 0;
				end if;
			elsif UNSIGNED(sc_count) = TO_UNSIGNED(1, 2) then
				mod_start		<= 0;
				if enable = '1' then
					hash_enable_1 <= 1;
					hash_enable_2 <= 1;
				else
					hash_enable_1 <= 0;
					hash_enable_2 <= 0;
				end if;
			elsif UNSIGNED(sc_count) = TO_UNSIGNED(2, 2) then
				if enable = '1' then
					mod_start <= 1;
					if mod_ready = '0' then
						hash_enable_1 <= 0;
						hash_enable_2 <= 0;
					else
						hash_enable_1 <= 1;
						hash_enable_2 <= 1;
					-- TODO
	
	
end arch;

