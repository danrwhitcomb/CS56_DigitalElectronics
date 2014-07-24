----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:21:49 07/23/2014 
-- Design Name: 
-- Module Name:    OutputRegister - Behavioral 
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

entity OutputRegister is
    Port ( rx_data_in : in  STD_LOGIC_VECTOR (7 downto 0);
           rx_data_out : out  STD_LOGIC_VECTOR (7 downto 0);
           LOAD : in  STD_LOGIC;
           Clk : in  STD_LOGIC);
end OutputRegister;

architecture Behavioral of OutputRegister is

signal iData : std_logic_vector(7 downto 0);

begin

LoadRegister: process(Clk)
begin

if(rising_edge(Clk))
then
	if(LOAD = '1')
	then
		iData <= rx_data_in;
	end if;
end if;
end process LoadRegister;

rx_data_out <= iData;
end Behavioral;

