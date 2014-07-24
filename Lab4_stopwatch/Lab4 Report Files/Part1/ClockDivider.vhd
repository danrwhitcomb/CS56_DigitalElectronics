----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:16:44 07/15/2014 
-- Design Name: 
-- Module Name:    ClockDivider - Behavioral 
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

entity ClockDivider is
    Port ( CE_OUT : out  STD_LOGIC;
           Clk : in  STD_LOGIC);
end ClockDivider;

architecture Behavioral of ClockDivider is

constant DIVIDER : integer := 10;
signal clk_div : integer := 0;

begin

ClockDivider: process(clk)
begin
	if(rising_edge(clk))
	then
		if(clk_div = DIVIDER - 1)
		then
			CE_OUT <= '1';
			clk_div <= 0;
		else
			CE_OUT <= '0';
			clk_div <= clk_div + 1;
		end if;
	end if;
end process ClockDivider;
end Behavioral;

