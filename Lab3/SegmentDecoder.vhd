----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:25:13 07/15/2014 
-- Design Name: 
-- Module Name:    mux7seg - Behavioral 
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

entity mux7seg is
    Port ( clk : in  STD_LOGIC;
           y0 : in  STD_LOGIC_VECTOR (3 downto 0);
           y1 : in  STD_LOGIC_VECTOR (3 downto 0);
           y2 : in  STD_LOGIC_VECTOR (3 downto 0);
           y3 : in  STD_LOGIC_VECTOR (3 downto 0);
           seg : out  STD_LOGIC_VECTOR (0 downto 6);
           an : out  STD_LOGIC_VECTOR (3 downto 0));
end mux7seg;

architecture Behavioral of mux7seg is



end Behavioral;

