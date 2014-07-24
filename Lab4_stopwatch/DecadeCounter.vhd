----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 	Daniel Whitcomb
-- 
-- Create Date:    00:59:23 07/15/2014 
-- Design Name: 
-- Module Name:    DecadeCounter - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DecadeCounter is
    Port ( en_in : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           clk : in STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR (3 downto 0);
           en_out : out  STD_LOGIC);
end DecadeCounter;

architecture Behavioral of DecadeCounter is

signal iQ : unsigned(3 downto 0) := "0000";
signal ien_out : std_logic;

begin
Count: process(clk)
begin

if(rising_edge(clk))
then

	if(reset = '1')
	then
		iQ <= "0000";
	elsif(ien_out = '1')
	then
		ien_out <= '0';
	elsif(en_in = '1')
	then
		if(iQ = "1001")
		then
			ien_out <= '1';
			iQ <= "0000";
		else
			iQ <= iQ+1;
		end if;
	end if;
	
	
end if;
end process Count;
Q <= STD_LOGIC_VECTOR(iQ);
en_out <= ien_out;
end Behavioral;

