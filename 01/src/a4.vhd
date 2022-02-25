-- author: Jimmy Sheng
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity a4 is
	Port(	A, B, C, D		:in	std_logic;
			FO, EO			:out	std_logic);
end a4;

architecture q2 of a4 is
signal E:	std_logic;
begin
	E <= (A OR B OR D) AND (NOT C);
	EO <= E;
	FO <= (((A AND B) OR C) XOR ((C AND D) OR E)) OR ((A AND E) OR NOT (B AND C));
end q2;
