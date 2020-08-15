LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;

entity AAC2M2P1 is port (                 	
   CP: 	in std_logic; 	-- clock
   SR:  in std_logic;  -- Active low, synchronous reset
   P:    in std_logic_vector(3 downto 0);  -- Parallel input
   PE:   in std_logic;  -- Parallel Enable (Load)
   CEP: in std_logic;  -- Count enable parallel input
   CET:  in std_logic; -- Count enable trickle input
   Q:   out std_logic_vector(3 downto 0);            			
    TC:  out std_logic  -- Terminal Count
);            		
end AAC2M2P1;



architecture behav of AAC2M2P1 is
signal var : std_logic_vector(4 downto 0); 
begin


--process (PE)
--begin
--    if (PE = '1') then
--    var <= P;
--    else 
--    var <= var;
--    end if;
--end process;

process(CP, SR)
begin
 if(SR = '0') then
	var <= "00000";
 elsif(PE = '0') then
	var <= '0' & P;
 elsif(CP = '1' and CEP='1' and CET = '1') then
	var <= var + 1;
	--if (var = "1111") then
	--   TC <= '1';
	--else 
	--   TC <= '0';
	--end if;
 elsif(CP = '1' and (CEP='0' or CET = '0')) then
	var <= var ;
 end if;
end process;


Q <= var(3 downto 0);
--TC <= var(4);

process(var)
begin
if (var = "1111") then
	TC <= '1';
else 
	TC <= '0';
end if;
end process;

end architecture behav;