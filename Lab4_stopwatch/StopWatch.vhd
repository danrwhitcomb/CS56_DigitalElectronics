----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:23:23 07/15/2014 
-- Design Name: 
-- Module Name:    StopWatchController - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity StopWatchController is
    Port ( BUTTON : in  STD_LOGIC;
			  clk : in STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR (1 downto 0));
end StopWatchController;

architecture Behavioral of StopWatchController is

type state_type is (reset, counting, stopped, pressedR, pressedC, pressedS);
signal state, next_state : state_type;
signal iQ : std_logic_vector(1 downto 0) :="00";
signal prev_iQ : std_logic_vector(1 downto 0) :="00";

begin
Control :process(BUTTON, state)
begin
	iQ <= prev_iQ;
	next_state <= state;
	case state is
		when counting =>
			if(BUTTON = '1')
			then
				next_state <= pressedC;
			end if;
		when stopped =>
			if(BUTTON = '1')
			then
				next_state <= pressedS;
			end if;
		when reset =>
			if (BUTTON = '1')
			then
				next_state <= pressedR;
			end if;
		when pressedC =>
			if(BUTTON = '0')
			then
				next_state <= stopped;
				iQ <= "10";
			end if;
		
		when pressedS =>
			if(BUTTON = '0')
			then
				next_state <= reset;
				iQ <= "00";
			end if;
			
		when pressedR =>
			if(BUTTON = '0')
			then
				next_state <= counting;
				iQ <= "11";
			end if;
		
		when others => null
			;

	end case;
end process Control;


StateUpdate: process(clk)
begin
if rising_edge(clk) then
	state <= next_state;
	prev_iQ <= iQ;
end if;
end process;

Q <= iQ;


end Behavioral;

