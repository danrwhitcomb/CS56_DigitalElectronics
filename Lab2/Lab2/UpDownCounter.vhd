----------------------------------------------------------------------------------
-- Company: 		 	Engs 31 14X
-- Engineer: 		 	E.W. Hansen (replace with your name)
-- 
-- Create Date:    	07/02/2008, checked 07/03/2014
-- Design Name:
-- Module Name:    	Lab2updown - Behavioral 
-- Project Name:		Lab 2 
-- Target Devices: 	Spartan 3E
-- Tool versions:  	ISE 14.4
-- Description:    	2-bit up-down counter for Lab 2.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;		-- for unsigned data type and arithmetic

entity Lab2updown is
    Port ( Clk	: 	in   	STD_LOGIC;	
		   UP_L	:	in		STD_LOGIC;	-- 0 for UP, 1 for DOWN
           Q 	: 	out  	STD_LOGIC_VECTOR (1 downto 0));	-- 2-bit counter output
end Lab2updown;

architecture Behavioral of Lab2updown is
-- internal signals
	signal iQ :	unsigned(1 downto 0) := "00"; 	-- 2-bit counter state
begin	
		
TwoBitCounter: process( Clk )
begin
	if rising_edge(Clk) then
		if UP_L = '0'
			then iQ <= iQ+1;
			else iQ <= iQ-1;
		end if;
	end if;
end process TwoBitCounter;

-- Map internal count to output port (type conversion)	
Q <= std_logic_vector(iQ);		

end Behavioral;