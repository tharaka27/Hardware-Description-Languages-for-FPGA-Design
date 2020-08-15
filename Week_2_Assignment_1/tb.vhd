LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use work.all;

entity tb is 
end tb;

architecture behavior of tb is
  signal CP_tb:  std_logic := '0'; --clock in
  signal SR_tb:  std_logic := '1';   -- Active low, synchronous reset
  signal P_tb:  std_logic_vector(3 downto 0);  -- data input
  signal PE_tb:  std_logic := '1';    -- Parallel Enable (Load)
  signal CEP_tb: std_logic := '0'; --Count enable parallel input
  signal CET_tb: std_logic := '0'; --count enable trickle input
  signal Q_tb: std_logic_vector(3 downto 0); -- output count
  signal TC_tb: std_logic; --output TC




component AAC2M2P1 
   port (                 
    CP: in std_logic;
	SR: in std_logic;
	P: in std_logic_vector(3 downto 0);
	PE: in std_logic;
	CEP: in std_logic;
	CET: in std_logic;
	Q: out std_logic_vector(3 downto 0);
	TC: out std_logic
    );  
end component;

begin
Counter : AAC2M2P1
    port map( 
        -- Inputs
        CP => CP_tb,
		SR => SR_tb,
		P => P_tb,
		PE => PE_tb,
		CEP => CEP_tb,
		CET => CET_tb,
		-- outputs
		Q => Q_tb,
		TC => TC_tb
        );  


process 
begin
SR_tb <= '0';
wait for 10ns;
SR_tb <= '1';
wait;
end process;

process
begin
CP_tb <= not CP_tb;
wait for 10ns;
end process;

process
begin
PE_tb <= '1';
wait for 300ns;
PE_tb <= '0';
P_tb <= "1000";
wait for 10ns;
PE_tb <= '1';
wait;
end process;


process
begin
CEP_tb <= '1';
CET_tb <= '1';
wait for 600ns;
CET_tb <= '0';
wait;
end process;

end architecture behavior;