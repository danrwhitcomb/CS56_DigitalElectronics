----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:17:23 07/07/2014 
-- Design Name: 
-- Module Name:    TailLights - Blink 
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

entity TailLights is
    Port ( LEFT : in  STD_LOGIC;
           RIGHT : in  STD_LOGIC;
           HAZ : in  STD_LOGIC;
           LC : out  STD_LOGIC;
           LB : out  STD_LOGIC;
           LA : out  STD_LOGIC;
           RA : out  STD_LOGIC;
           RB : out  STD_LOGIC;
           RC : out  STD_LOGIC;
			  clk: in STD_LOGIC);
end TailLights;

architecture Blink of TailLights is
begin

	process(clk)
	begin
		if(rising_clock(clk)) then
			
		end if;
	end process;
end Blink;

