LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

ENTITY RAM128_32 IS
	PORT
	(
		address	: IN STD_LOGIC_VECTOR (6 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END RAM128_32;


architecture behavioral of RAM128_32 is
	type Memory is array (0 to 127)of std_logic_vector(31 DOWNTO 0);
	signal mem: Memory;
begin

--Writing to the memory
process(wren,clock)
begin
if(wren = '1') then
	if( clock = '1') then
		mem(to_integer(unsigned(address))) <= data;
	end if;
end if;
end process;


--Reading from the memory
process(clock)
begin
q <= mem(to_integer(unsigned(address)));
end process;


end architecture behavioral;