----------------------------------------------------------------------------------
-- Company: 		 Engs 31 14X
-- Engineer: 		 Shell : E.W. Hansen
--						 Additions: Richard Cornew & Dan Whitcomb
-- 
-- Create Date:      15:44:25 07/25/2009 
-- Design Name: 
-- Module Name:      lab5top - Behavioral 
-- Project Name:	 	Lab 5 
-- Target Devices:   Spartan 6 / Nexys 3
-- Tool versions:    ISE 14.4
-- Description:      Top level shell for Lab 5 (RS-232 serial link)
--
-- Dependencies:     SerialRx.vhd (eventually, SerialTx.vhd)
--
-- Revision: 
-- Revision 0.01 - File Created
--		Revised (EWH) 7.19.2014 for Nexys3 board and updated lab flow
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library UNISIM;					-- needed for the BUFG component
use UNISIM.Vcomponents.ALL;

entity lab5top is
    Port ( Clk : in  STD_LOGIC;					-- 100 MHz board clock
           RsRx  : in  STD_LOGIC;				-- Rx input
			  RsTx  : out  STD_LOGIC;				-- Tx output
           --
           -- Testing ports
			  tx_start_p : in std_logic;
			  start_p : out std_logic;
           clk10_p : out std_logic;				-- 10 MHz clock
           RsRx_p : out std_logic;				-- serial data stream
		   rx_shift_p : out std_logic;			-- Rx register shift           
		   rx_done_tick_p : OUT  std_logic;	-- data ready
			segments : out std_logic_vector(6 downto 0);
			anodes : out std_logic_vector( 3 downto 0));
			
end lab5top;

-- This is the eventual version with transmitter included
--entity lab5top is
--    Port ( Clk : in  STD_LOGIC;
--           RsRx  : in  STD_LOGIC;
--			 RsTx  : in  STD_LOGIC );
--end lab5top;

architecture Structural of lab5top is

-- Signals for the 100 MHz to 10 MHz clock divider
constant CLOCK_DIVIDER_VALUE: integer := 5;
signal clkdiv: integer := 0;			-- the clock divider counter
signal clk_en: std_logic := '0';		-- terminal count
signal clk10: std_logic;				-- 10 MHz clock signal

-- Other signals
signal rx_bit : std_logic;
signal rx_data : std_logic_vector(7 downto 0);
signal rx_done_tick : std_logic;
signal tie_low: std_logic;
signal rx_shift_i : std_logic;
signal start : std_logic;

--Mux signals
signal irx_data : std_logic_vector(7 downto 0);

-- Component declarations
COMPONENT SerialTx 
	PORT( Clk : in  STD_LOGIC;
           tx_data : in  STD_LOGIC_VECTOR (7 downto 0);
           tx_start : in  STD_LOGIC;
           tx : out  STD_LOGIC;					-- to Nexys 2 RS-232 port
           tx_done_tick : out  STD_LOGIC );
	END COMPONENT;
	
COMPONENT SerialRx
	PORT(
	Clk : in STD_LOGIC;
	RsRx : in STD_LOGIC;
	rx_data : out std_logic_vector( 7 downto 0);
	rx_done_tick : out std_logic;
	rx_shift : out std_logic);
END COMPONENT;
-- Multiplexed seven segment display
COMPONENT mux7seg is
    PORT ( 	clk : in  STD_LOGIC;
           	y0, y1, y2, y3 : in  STD_LOGIC_VECTOR (3 downto 0);
	   	 	bi : in  STD_LOGIC;							
           	seg : out  STD_LOGIC_VECTOR (0 to 6);	
           	an : out  STD_LOGIC_VECTOR (3 downto 0) );			
end COMPONENT;


	
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
------------------------------

-- Map testing signals to toplevel ports

SRX: SerialRx PORT MAP(
	Clk => clk10,
	RsRx => RsRx,
	rx_data => irx_data,
	rx_shift => rx_shift_p,
	rx_done_tick => rx_done_tick_p
);

TRX: SerialTx PORT MAP(
	tx_data => irx_data,
	tx => RsTx,
	tx_done_tick => open,
	tx_start => tx_start_p,
	clk => clk10
);

--RsRx_p <= RsRx;
start_p <= tx_start_p;
-- Instantiate the multiplexed seven segment display
tie_low <= '0';
display: mux7seg
    Port Map ( clk => clk ,	-- runs off the fast master clock
           	y3 => "0000", 		-- most significant digit
           	y2 => "0000",  	--		map to actual signals
           	y1 => irx_data(7 downto 4), 		--		when you add counter instances
           	y0 => irx_data(3 downto 0),		-- least significant digit
	   		bi => tie_low,						
           	seg => segments,
           	an => anodes );	
		
end Structural;
