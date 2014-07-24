----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:39:47 07/07/2014 
-- Design Name: 
-- Module Name:    TurnSignals - Blink 
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

entity TurnSignals is
    Port ( LEFT : in  STD_LOGIC;
            RIGHT : in  STD_LOGIC;
            HAZ : in  STD_LOGIC;
			BRAKE : in STD_LOGIC;
            lights : out std_logic_vector(5 downto 0);
            clk : in  STD_LOGIC);
end TurnSignals;

architecture Blink of TurnSignals is
	signal ilights : std_logic_vector(5 downto 0);
begin
	process(clk)
	begin
		if (rising_edge(clk)) then
			case ilights is

				when "000000" =>
					if(HAZ = '1') 
						then ilights <= "111111";
					elsif(LEFT AND not(RIGHT)) = '1' 
						then ilights <= "000100";
					elsif(NOT(LEFT) AND RIGHT) = '1' 
						then ilights <= "001000";
					end if;
				when "111111" =>
					ilights <= "000000";

				when "001000" =>
					if(HAZ or (NOT(LEFT) AND RIGHT)) = '1' 
						then ilights <= "000000";
					else ilights <= "011000";
					end if;
					if(BRAKE = '1') 
					then
						ilights(0) <= '1';
						ilights(1) <= '1';
						ilights(2) <= '1';
					end if;
				when "011000" =>
					if(HAZ or (NOT(LEFT) AND RIGHT)) = '1'
						then ilights <= "000000";
						else ilights <= "111000";
					end if;
					if(BRAKE = '1') 
					then
						ilights(0) <= '1';
						ilights(1) <= '1';
						ilights(2) <= '1';
					end if;
				when "111000" =>
					if((BRAKE AND LEFT) = '1')
					then
						ilights <= "000111";
					elsif((BRAKE AND RIGHT) = '1')
					then 
						ilights <= "111100";
					else 
						ilights <= "000000";
					end if;
				when "000100" =>
					if(HAZ or (LEFT AND NOT(RIGHT))) = '1'
						then ilights <= "000000";
						else ilights <= "000110";
					end if;
					if(BRAKE = '1') 
					then
						ilights(3) <= '1';
						ilights(4) <= '1';
						ilights(5) <= '1';
					end if;
				when "000110" =>
					if(HAZ or (LEFT AND NOT(RIGHT))) = '1' 
						then ilights <= "000000";
						else ilights <= "000111";
					end if;
					if(BRAKE = '1') 
					then
						ilights(3) <= '1';
						ilights(4) <= '1';
						ilights(5) <= '1';
					end if;
				when "000111" =>
					if((BRAKE AND LEFT) = '1')
					then
						ilights <= "001111";
					elsif ((BRAKE AND RIGHT) = '1')
					then 
						ilights <= "111000";
					end if;
				-- Brake cases
				when "001111" =>
					if(BRAKE='1')
						then ilights <= "011111";
						else ilights <= "011000";
					end if;
				when "011111" =>
					if(BRAKE='1')
						then ilights <= "111111";
						else ilights <= "111000";
					end if;
				when "111100" =>
					if(BRAKE = '1')
						then ilights <= "111110";
						else ilights <= "000110";
					end if;
				when "111110" =>
					if(BRAKE = '1')
						then ilights <= "111111";
						else ilights <= "000111";
					end if;
				when others =>
					ilights <= "000000";

			end case;

		end if;
	end process;
	
	lights <= std_logic_vector(ilights);
end Blink;

