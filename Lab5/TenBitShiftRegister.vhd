----------------------------------------------------------------------------------
-- Company: 		COSC 56/ENGS 31 
-- Engineer: 		Daniel Whitcomb
-- 
-- Create Date:    21:59:43 07/20/2014 
-- Design Name: 
-- Module Name:    TenBitShiftRegister - Behavioral 
-- Project Name: 	 Lab 4 - Problem 4
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TenBitShiftRegister is
    Port ( CLK : in STD_LOGIC;
			  CLEAR : in  STD_LOGIC;
           SHIFT : in  STD_LOGIC;
           DATA : in  STD_LOGIC;
           DATA_OUT : out  STD_LOGIC_VECTOR (7 downto 0));
end TenBitShiftRegister;

architecture Behavioral of TenBitShiftRegister is

signal iData : std_logic_vector(9 downto 0) := (others => '0');
signal iOutputRegister : std_logic_vector(7 downto 0) := (others => '0');

constant divider : integer := 10;
signal slow_clk : std_logic := '0';
signal clk_div : integer := 0;
begin

ShiftData : process(slow_clk)
begin

if(rising_edge(slow_clk))
then
	if(CLEAR = '1')
	then
		iData <= (others => '0');
	elsif (SHIFT = '1')
	then
		iData(8 downto 0) <= iData(9 downto 1);
		iData(9) <= DATA;
	end if;
	
	iOutputRegister <= iData(8 downto 1);

end if;
end process ShiftData;

ClockDivider : process(CLK)
begin

if(rising_edge(CLK))
then
	if(clk_div = divider - 1)
	then
		slow_clk <= '1';
		clk_div <= 0;
	else
		slow_clk <= '0';
		clk_div <= clk_div + 1;
	end if;
end if;
end process ClockDivider;

DATA_OUT <= iOutputRegister;
end Behavioral;

