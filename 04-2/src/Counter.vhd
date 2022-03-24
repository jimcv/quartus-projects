-- 3-bit counter (up to 7)
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Counter is
	Port(	reset		:in		std_logic;
			start		:in		std_logic;
			clk		:in		std_logic;
			target	:in		std_logic_vector(13 downto 0);
			done		:out		std_logic;
			count		:inout	std_logic_vector(18 downto 0));
end Counter;

architecture count of Counter is
-- wait for pipeline to finish
signal pipetarget:		unsigned(18 downto 0);
begin
	pipetarget	<= RESIZE(UNSIGNED(target) * 21, 19);
	process(clk, reset, start)
	begin
		-- async reset
		if reset = '1' then
			count		<= STD_LOGIC_VECTOR(TO_UNSIGNED(0, 19));
			done		<= '0';
		-- if enabled
		elsif start = '1' then
			if rising_edge(clk) then
				if (UNSIGNED(count) + 1) >= pipetarget then
					done	<= '1';
				else
					count <= STD_LOGIC_VECTOR(UNSIGNED(count) + 1);
					done	<= '0';
				end if;
			end if;
		end if;
	end process;
end count;
