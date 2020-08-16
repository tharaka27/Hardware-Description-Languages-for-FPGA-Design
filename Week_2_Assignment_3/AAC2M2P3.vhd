library ieee;
use ieee.std_logic_1164.all;

entity FSM is

-- Defining states of the finite state machine
--generic(
	--S_Width: integer := 2 -- State Width
	--State_A: std_logic_vector(1 downto 0) := "00";
	--State_B: std_logic_vector(1 downto 0) := "01";
	--State_C: std_logic_vector(1 downto 0) := "10"
--);

-- Defining ports of the finite state machine
port (In1: in std_logic;
   RST: in std_logic; 
   CLK: in std_logic;
   Out1 : inout std_logic);


end FSM;


architecture FSM_Arch of FSM is
	--signal CurrentState, NextState : std_logic_vector(1 downto 0);
	--signal State_A: std_logic_vector(1 downto 0) := "00";
	--signal State_B: std_logic_vector(1 downto 0) := "01";
	--signal State_C: std_logic_vector(1 downto 0) := "10";
	type states is (State_A,State_B,State_C);
	signal CurrentState     : states;
	signal NextState     : states;
	signal LastOutput    : std_logic;

begin


-- Combinational circuit for the state machine
comb_proc : process(In1, CurrentState)
begin
 case(CurrentState) is
	when State_A =>
		if(In1 = '0') then      NextState <= State_A;
		elsif(In1 = '1') then   NextState <= State_B;
		else 			NextState <= State_A;
		end if;
	when State_B =>
		if(In1 = '0') then      NextState <= State_C;
		elsif(In1 = '1') then   NextState <= State_B;
		else 			NextState <= State_B;
		end if;
	when State_C =>
		if(In1 = '0') then      NextState <= State_C;
		elsif(In1 = '1') then   NextState <= State_A;
		else 			NextState <= State_C;
		end if;
	when others  =>			NextState <= State_A;
 end case;
end process comb_proc;


-- Sequential circuit for the state machine
clk_proc : process(CLK, RST,In1)
begin
	if(RST = '1') then currentState <= State_A;
	elsif(rising_edge(CLK)) then CurrentState <= NextState;
	end if;
end process clk_proc;


--  Generating output of the state machine
out_proc : process(CLK, RST,In1)
begin
 case(CurrentState) is
	when State_A =>
		Out1 <= '0';
		LastOutput <= '0';
	when State_B =>
		Out1 <= '0';
		LastOutput <= '0';
	when State_C =>
		Out1 <= '1';
		LastOutput <= '1';
	when others  =>			Out1 <= LastOutput;
 end case;
end process out_proc;

end architecture FSM_Arch;
