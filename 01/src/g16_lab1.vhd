-- author: 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity g16_lab1 is
	Port(	clk			:in	std_logic;
			countbytwo	:in	std_logic;
			rst			:in	std_logic;
			enable		:in	std_logic;
			max_count	:in	std_logic_vector(15 downto 0);
			output		:out	std_logic_vector(15 downto 0));
end g16_lab1;

architecture counter of g16_lab1 is

signal count:		unsigned(15 downto 0);

begin
	process(clk)
	begin
		-- if enabled
		if enable = '1' then
			if rising_edge(clk) then
				-- if max_count = 0 we keep count at 0 and stop
				if unsigned(max_count) = 0 then
					count <= TO_UNSIGNED(0, 16);
				-- reached max count, reset to 0
				elsif count = unsigned(max_count) then
					count <= TO_UNSIGNED(0, 16);
					-- but if countbytwo, increment by 1 again
					if countbytwo = '1' then
						count <= count + 1;
					end if;
				else
					count <= count + 1;
					-- but if countbytwo, increment by 1 again
					if countbytwo = '1' then
						-- reached max count, reset to 0
						if count = unsigned(max_count) then
							count <= TO_UNSIGNED(0, 16);
						else
							count <= count + 1;
						end if;
					end if;
				end if;
			end if;
		end if;
	end process;
	
	-- async reset
	count <= TO_UNSIGNED(0, 16) when rst = '1';
	output <= std_logic_vector(count);
				
end counter;
