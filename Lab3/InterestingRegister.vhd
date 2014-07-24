----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:21:22 07/15/2014 
-- Design Name: 
-- Module Name:    InterestingRegister - Behavioral 
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

entity InterestingRegister is
    Port ( I : in  STD_LOGIC_VECTOR (7 downto 0);
           O : out  STD_LOGIC_VECTOR (7 downto 0);
           s : in  STD_LOGIC_VECTOR (1 downto 0);
           clk : in  STD_LOGIC);
end InterestingRegister;

architecture Behavioral of InterestingRegister is

constant load : std_logic_vector(1 downto 0) := "01";
constant clear : std_logic_vector(1 downto 0) := "10";
constant swap  : std_logic_vector(1 downto 0) := "11";

begin
RegisterThings: process(clk)
begin
if(rising_edge(clk))
then

case s is

	when load =>
		O <= I;
	when clear => 
		O <= (7 downto 0 => '0');
	when swap => 
		O(0) <= I(4);
		O(1) <= I(5);
		O(2) <= I(6);
		O(3) <= I(7);

		O(4) <= I(0);
		O(5) <= I(1);
		O(6) <= I(2);
		O(7) <= I(3);
	when others =>
	
end case;
end if;

end process RegisterThings;

end Behavioral;

