----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:32:43 07/23/2014 
-- Design Name: 
-- Module Name:    Synchronizer - Behavioral 
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

entity Synchronizer is
    Port ( clk : in  STD_LOGIC;
           Din : in  STD_LOGIC;
           Dout : out  STD_LOGIC);
end Synchronizer;

architecture Behavioral of Synchronizer is

signal Dsync: std_logic;

begin

Flop : process( clk ) is 
begin
	if rising_edge( clk ) 
	then 
		Dsync <= Din;
		Dout <= Dsync;
	end if;
end process Flop;
end Behavioral;

