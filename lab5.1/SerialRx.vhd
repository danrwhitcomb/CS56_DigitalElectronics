----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:18:43 07/23/2014 
-- Design Name: 
-- Module Name:    SerialRx - Behavioral 
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

entity SerialRx is
PORT(
	Clk : in STD_LOGIC;
	RsRx : in STD_LOGIC;
	rx_data : out std_logic_vector( 7 downto 0);
	rx_done_tick : out std_logic;
	rx_shift : out std_logic
);
end SerialRx;

architecture Behavioral of SerialRx is

COMPONENT Synchronizer
	PORT(clk : in  STD_LOGIC;
           Din : in  STD_LOGIC;
           Dout : out  STD_LOGIC);
END COMPONENT;


COMPONENT SerialRxController is
	 Port ( CLK : in  STD_LOGIC;
           DATA_IN : in  STD_LOGIC;
           SHIFT : out  STD_LOGIC;
			  LOAD : out STD_LOGIC;
           RX_DONE : out  STD_LOGIC);
END COMPONENT;


COMPONENT TenBitShiftRegister is
	PORT ( CLK : in STD_LOGIC;
			  CLEAR : in  STD_LOGIC;
           SHIFT : in  STD_LOGIC;
           DATA : in  STD_LOGIC;
           DATA_OUT : out  STD_LOGIC_VECTOR (7 downto 0));
END COMPONENT;

COMPONENT OutputRegister is 
	PORT( rx_data_in : in  STD_LOGIC_VECTOR (7 downto 0);
         rx_data_out : out  STD_LOGIC_VECTOR (7 downto 0);
         LOAD : in  STD_LOGIC;
         Clk : in  STD_LOGIC);
END COMPONENT;

signal synced_data : std_logic;
signal iClear : std_logic;
signal iShift : std_logic;
signal iLoad : std_logic;
signal iData_out : std_logic_vector(7 downto 0);

begin

DFlopSync: Synchronizer PORT MAP (
	clk => Clk,
	Din => RsRx,
	Dout => synced_data
);

ShiftRegister: TenBitShiftRegister PORT MAP (
	CLK => Clk,
	CLEAR => iClear,
	SHIFT => iShift,
	DATA => synced_data,
	DATA_OUT => iData_out
);

Controller: SerialRxController PORT MAP (
	CLK => Clk,
	DATA_IN => synced_data,
	SHIFT => iShift,
	LOAD => iLoad,
	RX_DONE => rx_done_tick
);

DataOut: OutputRegister PORT MAP (
	rx_data_in => iData_out,
	rx_data_out => rx_data,
	LOAD => iLoad,
	Clk => Clk
);

rx_shift <= iShift;
end Behavioral;

