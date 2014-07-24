----------------------------------------------------------------------------------
-- Company: 			Engs 31 14X
-- Engineer: 			Daniel Whitcomb & Richard Cornew
-- 
-- Create Date:    	 
-- Design Name: 		
-- Module Name:    		lab3
-- Project Name: 		Lab3
-- Target Devices: 		Digilent NEXYS3 (Spartan 6)
-- Tool versions: 		ISE Design Suite 14.4
-- Description: 		Tbird tail light lab
--				
-- Dependencies: 
--
-- Revision: 
-- Revision 0.02 - File Created
-- Revised (EWH), 3 July 2014, for the Nexys3 board
-- Additional Comments: 
--
----------------------------------------------------------------------------------
-- Boilerplate: don't change this
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;		-- needed for arithmetic

library UNISIM;					-- needed for the BUFG component
use UNISIM.Vcomponents.ALL;


-- Entity block
-- Change the name of the entity from Lab3_shell to something more descriptive,
-- like Lab3_Tbird.

entity TBIRD is
port ( LeftTurn, RightTurn, Hazard, Brake, clk 	: in std_logic;
       LC, LB, LA, RA, RB, RC 					: out std_logic );
end TBIRD; 

architecture Behavioral of TBIRD is
-- Signals for the clock divider, which divides the 100 MHz clock down to 4 Hz
-- 100 MHz / CLOCK_DIVIDER_VALUE = 8 Hz
constant CLOCK_DIVIDER_VALUE: integer := 5;
signal clkdiv: integer := 0;		-- the clock divider counter
signal clk_en: std_logic := '0';	-- terminal count
signal slow_clk: std_logic;			-- the slow clock

-- Signal declarations for your state machine go here
type statetype is (L1, L2, L3, R1, R2, R3, AllOff, AllOn, BrakeL1, BrakeL2, BrakeR1, BrakeR2);
signal state, nextState : statetype;

constant iL1 : STD_LOGIC_VECTOR(5 downto 0) := "001000";
constant iL2 : STD_LOGIC_VECTOR(5 downto 0) := "011000";
constant iL3 : STD_LOGIC_VECTOR(5 downto 0) := "111000";
constant iR1 : STD_LOGIC_VECTOR(5 downto 0) := "000100";
constant iR2 : STD_LOGIC_VECTOR(5 downto 0) := "000110";
constant iR3 : STD_LOGIC_VECTOR(5 downto 0) := "000111";
constant iAllOff : STD_LOGIC_VECTOR(5 downto 0) := "000000";
constant iAllOn : STD_LOGIC_VECTOR(5 downto 0) := "111111";
constant iBrakeL1 : STD_LOGIC_VECTOR(5 downto 0) := "001111";
constant iBrakeL2 : STD_LOGIC_VECTOR(5 downto 0) := "011111";
constant iBrakeR1 : STD_LOGIC_VECTOR(5 downto 0) := "111100";
constant iBrakeR2 : STD_LOGIC_VECTOR(5 downto 0) := "111110";

signal ilights : STD_LOGIC_VECTOR(5 downto 0) := "000000";

begin

-- Clock buffer for 4 Hz clock
-- The BUFG component puts the slow clock onto the FPGA clocking network
Slow_clock_buffer: BUFG
      port map (I => clk_en,
                O => slow_clk );

-- Divide the 100 MHz clock down to 8 Hz, then
-- toggling the clk_en signal at 8 Hz gives a 4 Hz clock with 50% duty cycle
Clock_divider: process(clk)
begin
	if rising_edge(clk) 
	then
		if clkdiv = CLOCK_DIVIDER_VALUE-1 
		then 
			clk_en <= NOT(clk_en);		
			clkdiv <= 0;
			state <= nextState;
		else
			clkdiv <= clkdiv + 1;
		end if;
	end if;
end process Clock_divider;

-- Your state machine code goes here
-- Clock your state machine with the slow_clk signal
TurnSignal: process(state, slow_clk, Hazard, LeftTurn, RightTurn, Brake)
begin
	nextState <= state;

	if (slow_clk = '1') 
	then	
		case state is
			when AllOff =>
				if(Hazard = '1') 
					then ilights <= iAllOn;
					nextState <= AllOn;
				elsif((LeftTurn and Brake) = '1')
				then
					ilights <= iBrakeL1;
					nextState <= BrakeL1;
				elsif((RightTurn and Brake) = '1')
				then
					ilights <= iBrakeR1;
					nextState <= BrakeR1;
				elsif(LeftTurn) = '1' 
				then 
					ilights <= iL1;
					nextState <= L1;
				elsif(RightTurn) = '1' 
				then 
					ilights <= iR1;
					nextState <= R1;
				end if;
			when AllOn =>
				if( Brake AND LeftTurn) = '1' 
				then 
					ilights <= iR3; 
					nextState <= R3;
				elsif (Brake AND RightTurn) = '1' 
				then 
					ilights <= iL3; 
					nextState <= L3;
				elsif( Brake = '1' ) 
				then 
					ilights <= iAllOn; 
					nextState <= AllOn;
				else 
					ilights <= iAllOff; 
					nextState <= AllOff;
				end if;
			when L1 =>
				if(Hazard or RightTurn) = '1' 
				then 
					ilights <= iAllOff;
					nextState <= AllOff;
				elsif (Brake = '1') 
				then
					ilights <= iBrakeL2;
					nextState <= BrakeL2;
				else 
					ilights <= iL2;
					nextState <= L2;
				end if;
			when L2 =>
				if(Hazard or (RightTurn)) = '1'
				then 
					ilights <= iAllOff; 
					nextState <= AllOff;
				elsif (Brake = '1') 
				then
					ilights <= iAllOn;
					nextState <= AllOn;
				else 
					ilights <= iL3; 
					nextState <= L3;
				end if;
			when L3 =>
				if((Brake AND LeftTurn) = '1')
				then
					ilights <= iR3;
					nextState <= R3;
				elsif((Brake AND RightTurn) = '1')
				then 
					ilights <= iBrakeR1;
					nextState <= BrakeR1;
				else 
					ilights <= iAllOff;
					nextState <= AllOff;
				end if;
			when R1 =>
				if(Hazard or (LeftTurn)) = '1'
				then ilights <= iAllOff; 
						nextState <= AllOff;
				elsif (Brake = '1') 
				then
					ilights <= iBrakeR2;
					nextState <= BrakeR2;
				else 
					ilights <= iR2;
					nextState <= R2;
				end if;
			when R2 =>
				if(Hazard or (LeftTurn)) = '1' 
				then 
					ilights <= iAllOff;
					nextState <= AllOff;
				elsif(Brake = '1')
				then 
					ilights <= iAllOn;
					nextState <= AllOn;
				else 
					ilights <= iR3;
					nextState <= R3;
				end if;
			when R3 =>
				if((Brake AND LeftTurn) = '1')
				then
					ilights <= iBrakeL1;
					nextState <= BrakeL1;
				elsif ((Brake AND RightTurn) = '1')
				then 
					ilights <= iL3;
					nextState <= L3;
				else
					ilights <= iAllOff;
					nextState <= AllOff;
				end if;
			-- Brake cases
			when BrakeL1 =>
				if(Brake='1')
				then 
					ilights <= iBrakeL2;
					nextState <= BrakeL2;
				else 
					ilights <= iL2;
					nextState <= L2;
				end if;
			when BrakeL2 =>
				if(Brake='1')
				then 
					ilights <= iAllOn;
					nextState <= AllOn;
				else 
					ilights <= iL3;
					nextState <= L3;
				end if;
			when BrakeR1 =>
				if(Brake = '1')
				then 
					ilights <= iBrakeR2;
					nextState <= BrakeR2;
				else 
					ilights <= iR2;
					nextState <= R2;
				end if;
			when BrakeR2 =>
				if(Brake = '1')
				then 
					ilights <= iAllOn;
					nextState <= AllOn;
				else 
					ilights <= iR3;
					nextState <= R3;
				end if;
			when others => null;
		end case;
	end if;
end process TurnSignal;

RC <= ilights(0);
RB <= ilights(1);
RA <= ilights(2);
LA <= ilights(3);
LB <= ilights(4);
LC <= ilights(5);
	
end Behavioral; 