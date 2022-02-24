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
	process(clk, rst)
	begin
		-- if reset
		if rst = '1' then
			count <= TO_UNSIGNED(0, 16);
		-- if enabled
		elsif rising_edge(clk) then
			if enable = '1' then
				-- if max_count = 0 we keep count at 0 and stop
				if unsigned(max_count) = 0 then
					count <= TO_UNSIGNED(0, 16);
				-- reached max count, reset to 0
				elsif (count = unsigned(max_count) and countbytwo = '0') then
					count <= TO_UNSIGNED(0, 16);
				-- but if countby two, increment by 1 again
				elsif (count = unsigned(max_count) and countbytwo = '1') then
					count <= TO_UNSIGNED(1, 16);
				-- max count - 1 but countbytwo
				elsif (count = (unsigned(max_count) - 1) and countbytwo = '1') then
					count <= TO_UNSIGNED(0, 16);
				else
					if countbytwo = '0' then
						count <= count + 1;
					else
						count <= count + 2;
					end if;
				end if;
			end if;
		end if;
	end process;
	
	-- wire signal to output
	output <= std_logic_vector(count);
				
end counter;
