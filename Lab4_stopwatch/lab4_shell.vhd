----------------------------------------------------------------------------------
-- Company: 			Engs 31 14X
-- Engineer: 			Daniel Whitcomb & Richard Cornew
-- 
-- Create Date:    	 
-- Design Name: 		
-- Module Name:    		lab4_shell 
-- Project Name: 		Lab4
-- Target Devices: 		Digilent NEXYS3 (Spartan 6)
-- Tool versions: 		ISE Design Suite 14.4
-- Description: 		Stopwatch lab
--				
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
-- Boilerplate: don't change this
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;		-- needed for arithmetic

library UNISIM;					-- needed for the BUFG component
use UNISIM.Vcomponents.ALL;

entity Stopwatch is
port (clk		: in std_logic;
	-- control inputs
		button : in std_logic;
	-- multiplexed seven segment display
      segments	: out std_logic_vector(6 downto 0);
      anodes 	: out std_logic_vector(3 downto 0);
		c : out std_logic;
		r : out std_logic;
		cntrl : out std_logic_vector(1 downto 0)
		);
end entity Stopwatch; 

architecture Behavioral of Stopwatch is

-- COMPONENT DECLARATIONS
-- Multiplexed seven segment display
signal tie_low: std_logic;
component mux7seg is
    Port ( 	clk : in  STD_LOGIC;
           	y0, y1, y2, y3 : in  STD_LOGIC_VECTOR (3 downto 0);
	   	 	bi : in  STD_LOGIC;							
           	seg : out  STD_LOGIC_VECTOR (0 to 6);	
           	an : out  STD_LOGIC_VECTOR (3 downto 0) );			
end component;

-- Debouncer
component debounce is
    Port ( clk 	: in  STD_LOGIC;
           switch 	: in  STD_LOGIC;		-- switch input
           dbswitch : out STD_LOGIC );		-- debounced output
end component;

-- Your component declarations go here

COMPONENT StopWatchController
	PORT(
		BUTTON : IN STD_LOGIC;
		clk : IN STD_LOGIC;
		Q : OUT STD_LOGIC_VECTOR(1 downto 0)
	);
END COMPONENT;

COMPONENT DecadeCounter
	PORT(
		clk : IN std_logic;
		en_in : IN std_logic;
		reset : IN std_logic;          
		Q : OUT std_logic_vector(3 downto 0);
		en_out : OUT std_logic );
END COMPONENT;

COMPONENT ClockDivider
	PORT(
		CE_OUT : OUT std_logic;
		Clk : IN std_logic
	);
END COMPONENT;

COMPONENT Decoded2BitCounter
	PORT(
		CE : in STD_LOGIC;
		sel : out STD_LOGIC_VECTOR (1 downto 0);
		an : out STD_LOGIC_VECTOR(3 downto 0)
	);
END COMPONENT;

COMPONENT FourToOneMux
	PORT(
		s : in STD_LOGIC_VECTOR (1 downto 0);
		y : in STD_LOGIC_VECTOR (15 downto 0);
		Q : out STD_LOGIC_VECTOR (3 downto 0)
	);
END COMPONENT;

-------------------------------------------------
-- SIGNAL DECLARATIONS 
-- Signals for the clock divider, which divides the 100 MHz clock down to 10 MHz
constant CLOCK_DIVIDER_VALUE: integer := 5;
signal clkdiv: integer := 0;			-- the clock divider counter
signal clk_en: std_logic := '0';		-- terminal count
signal clk10: std_logic;				-- the slower clock

signal button_db : std_logic;	-- debounced button

-- Signal declarations for your code go here
signal en_in0, en_in1, en_in2, en_in3 : std_logic;
signal iy0, iy1, iy2, iy3 : std_logic_vector(3 downto 0);
signal control : std_logic_vector(1 downto 0);
signal clear : std_logic;
signal running: std_logic;

begin
-- Clock buffer for 10 MHz clock
-- The BUFG component puts the slow clock onto the FPGA clocking network
Slow_clock_buffer: BUFG
      port map (I => clk_en,
                O => clk10 );

-- Divide the 100 MHz clock down to 20 MHz, then toggling the 
-- clk_en signal at 20 MHz gives a 10 MHz clock with 50% duty cycle
Clock_divider: process(clk)
begin
	if rising_edge(clk) then
	   	if clkdiv = CLOCK_DIVIDER_VALUE-1 then 
	   		clk_en <= NOT(clk_en);		
			clkdiv <= 0;
		else
			clkdiv <= clkdiv + 1;
		end if;
	end if;
end process Clock_divider;

running <= en_in0 AND control(1) and control(0);
clear <= not(control(0)) and not(control(1));

-- Instantiate the debouncer
debouncer: debounce
    Port map ( clk => clk10,	-- runs off the slow clock
           switch => button,
           dbswitch => button_db );	
			 
Controller: StopWatchController
	PORT MAP (
		clk=>clk,
		BUTTON => button,
		Q => control
	);
			  
Counter1: DecadeCounter
	PORT Map (
		clk => clk10,
		en_in => running,
		Q => iy0,
		reset => clear,
		en_out => en_in1
	);
	
Counter2: DecadeCounter
	PORT Map (
		clk => clk10,
		en_in => en_in1,
		Q => iy1,
		reset => clear,
		en_out => en_in2
	);
	
Counter3: DecadeCounter
	PORT MAP (
		clk => clk10,
		en_in => en_in2,
		Q => iy2,
		reset => clear,
		en_out => en_in3
		);

Counter4: DecadeCounter
	PORT MAP (
		clk => clk10,
		en_in => en_in3,
		Q => iy3,
		reset => clear,
		en_out => open
		);

divider: ClockDivider
	PORT Map(
		clk => clk10,
		CE_OUT => en_in0
	);

-- Instantiate the multiplexed seven segment display
tie_low <= '0';
display: mux7seg
    Port Map ( clk => clk ,	-- runs off the fast master clock
           	y3 => iy3, 		-- most significant digit
           	y2 => iy2,  	--		map to actual signals
           	y1 => iy1, 		--		when you add counter instances
           	y0 => iy0,		-- least significant digit
	   		bi => tie_low,						
           	seg => segments,
           	an => anodes );	

--------------------------------------------
-- Your logic goes here
-- Clock your system with the clk10 signal
c <= clear;
r <= button_db;
cntrl <= control;

end Behavioral; 