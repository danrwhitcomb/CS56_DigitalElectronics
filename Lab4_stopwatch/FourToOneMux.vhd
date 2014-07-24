----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:32:25 07/15/2014 
-- Design Name: 
-- Module Name:    FourToOneMux - Behavioral 
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

entity FourToOneMux is
    Port ( s : in  STD_LOGIC_VECTOR (1 downto 0);
           y : in  STD_LOGIC_VECTOR (15 downto 0);
           Q : out  STD_LOGIC_VECTOR (3 downto 0));
end FourToOneMux;

architecture Behavioral of FourToOneMux is
begin

Multiplex: process(s)
begin
case s is

	when "00" =>
		Q <= y(3 downto 0);
	when "01" =>
		Q <= y(7 downto 4);
	when "10" =>
		Q <= y(11 downto 8);
	when "11" =>
		Q <= y(15 downto 12);
	when others => null;

end case;
end process Multiplex;
end Behavioral;

