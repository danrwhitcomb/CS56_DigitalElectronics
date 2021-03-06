----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:10:37 07/07/2014 
-- Design Name: 
-- Module Name:    FlipFlopReset - Behavioral 
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

entity FlipFlopReset is
    Port ( reset : in  STD_LOGIC;
           d : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  q : out STD_LOGIC);
end FlipFlopReset;

architecture Behavioral of FlipFlopReset is
begin
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(r = 1) then
				Q <= '0';
			else
				Q <= d;
			end if;
		end if;
	end process;
end Behavioral;

