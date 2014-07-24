----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:36:26 07/15/2014 
-- Design Name: 
-- Module Name:    Decoded2BitCounter - Behavioral 
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

entity Decoded2BitCounter is
    Port ( CE : in  STD_LOGIC;
           sel : out  STD_LOGIC_VECTOR (1 downto 0);
           an : out  STD_LOGIC_VECTOR (3 downto 0));
end Decoded2BitCounter;

architecture Behavioral of Decoded2BitCounter is

type state_type is (A0, A1, A2, A3);
signal state, next_state : state_type;

begin

Count: process(state, CE)
begin
next_state <= state;

case state is
	when A0 =>
		an <= "1110";
		sel <= "00";
		next_state <= A1;
	when A1 =>
		an <= "1101";
		sel <= "01";
		next_state <= A2;
	when A2 =>
		an <= "1011";
		sel <= "10";
		next_state <= A3;
	when A3 =>
		an <= "0111";
		sel <= "11";
		next_state <= A0;
end case;

end process Count;

ClockEnable: process(CE)
begin
if(rising_edge(CE))
then
	state <= next_state;
end if;
end process ClockEnable;

end Behavioral;

