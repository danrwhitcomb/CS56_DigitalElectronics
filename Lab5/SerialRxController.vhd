----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 		Daniel Whitcomb
-- 
-- Create Date:    23:48:28 07/20/2014 
-- Design Name: 
-- Module Name:    SerialRxController - Behavioral 
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

entity SerialRxController is
    Port ( CLK : in  STD_LOGIC;
           DATA_IN : in  STD_LOGIC;
           SHIFT : out  STD_LOGIC;
			  LOAD : out STD_LOGIC;
           RX_DONE : out  STD_LOGIC;
           DATA_OUT : out  STD_LOGIC);
end SerialRxController;

architecture Behavioral of SerialRxController is

type state_type is (waiting, pulseCounting, shiftBit, transferBits, rx_done_tick);
signal next_state, state : state_type;

constant byte_size : integer := 8;
constant parity_size : integer := 0;
constant transfer_size : integer := byte_size + parity_size + 2;
constant baud_rate : integer := 115200;
constant clk_rate : integer := 10000000;
constant baud_rate_size : integer := clk_rate / baud_rate;

signal brg_ticks : integer := 0;
signal rate_identified : STD_LOGIC := '0';
signal read_bit : STD_LOGIC := '0';
signal bits_received : integer := 0;
signal prev_bits_received : integer := 0;

-- Internal holding signals
signal iDataOut, iTxOut, iShift, iLoad : STD_LOGIC := '0';
signal iDataOut_prev, iTxOut_prev, iShift_prev, iLoad_prev : STD_LOGIC;

begin


--Counter for BAUD rate generator cycles
BrgCounter: process(CLK)
begin

if(rising_edge(CLK))
then
	-- Case for start bit middle ID
	if(rate_identified='0' AND DATA_IN = '0')
	then
		if(brg_ticks = (baud_rate_size / 2) - 1)
		then
			rate_identified <= '1';
			brg_ticks <= 0;
		else 
			brg_ticks <= brg_ticks + 1;
		end if;
	-- Case for data bit middle ID
	elsif(rate_identified='1')
	then
		if(brg_ticks = baud_rate_size - 1)
		then
			brg_ticks <= 0;
			read_bit <= '1';
		else
			brg_ticks <= brg_ticks + 1;
			read_bit <= '0';
		end if;
	end if;
	
	if(iTxOut = '1')
	then
		rate_identified <= '0';
	end if;
end if;
end process BrgCounter;

BitCounter: process(CLK)
begin

if(rising_edge(CLK))
then
	bits_received <= prev_bits_received;
	if(read_bit = '1')
	then
		if(bits_received = transfer_size)
		then
			bits_received <= 0;
		else
			bits_received <= bits_received + 1;
		end if;
	end if;
end if;
end process BitCounter;

Controller: process(state, read_bit)
begin
	
	next_state <= state;
	iTxOut <= iTxOut_prev;
	iShift <= iShift_prev;
	iDataOut <= iDataOut_prev;
	iLoad <= iLoad_prev;
	
	case state is
		when waiting =>
			iTxOut <= '0';

			if(DATA_IN = '0')
			then
				next_state <= pulseCounting;
			end if;

		when pulseCounting =>
			
			iShift <= '0';

			if(read_bit = '1')
			then
				next_state <= shiftBit;
			end if;
			
			if(bits_received = transfer_size)
			then
				next_state <= transferBits;
			end if;
			
		when shiftBit =>
			iShift <= '1';
			iDataOut <= DATA_IN;
			next_state <= pulseCounting;
		
		when transferBits =>
			iLoad <= '1';
			next_state <= rx_done_tick;
		
		when rx_done_tick =>
			iLoad <= '0';
			iTxOut <= '1';
			next_state <= waiting;
	end case;
end process Controller;

Clock: process(CLK)
begin

if(rising_edge(CLK))
then
	state <= next_state;
	SHIFT <= iShift;
	DATA_OUT <= iDataOut;
	RX_DONE <= iTxOut;
	LOAD <= iLoad;
	
	prev_bits_received <= bits_received;
	iDataOut_prev <= iDataOut;
	iTxOut_prev <= iTxOut;
	iLoad_prev <= iLoad;
		
end if;
end process Clock;

end Behavioral;

