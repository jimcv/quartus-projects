-- 2-bit counter
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity State_Counter is
	Port(	reset		:in		std_logic;
			start		:in		std_logic;
			clk		:in		std_logic;
			target	:in		std_logic_vector(1 downto 0);
			done		:out		std_logic;
			count		:inout	std_logic_vector(1 downto 0));
end State_Counter;

architecture count of State__Counter is
begin
	process(clk, reset, start)
	begin
		-- async reset
		if reset = '1' then
			count		<= STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2));
			done		<= '0';
		-- if enabled
		elsif start = '1' then
			if rising_edge(clk) then
				if UNSIGNED(count) = UNSIGNED(target) then
					done	<= '1';
				else
					count <= STD_LOGIC_VECTOR(UNSIGNED(count) + 1);
					done	<= '0';
				end if;
			end if;
		end if;
	end process;
end count;
