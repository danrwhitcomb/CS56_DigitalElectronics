--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:33:45 07/22/2014
-- Design Name:   
-- Module Name:   /home/danrwhitcomb/Documents/Lab5/SerialRxController_tb.vhd
-- Project Name:  Lab5
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: SerialRxController
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY SerialRxController_tb IS
END SerialRxController_tb;
 
ARCHITECTURE behavior OF SerialRxController_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SerialRxController
    PORT(
         CLK : IN  std_logic;
         DATA_IN : IN  std_logic;
         SHIFT : OUT  std_logic;
         RX_DONE : OUT  std_logic;
         DATA_OUT : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal DATA_IN : std_logic := '1';

 	--Outputs
   signal SHIFT : std_logic;
   signal RX_DONE : std_logic;
   signal DATA_OUT : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SerialRxController PORT MAP (
          CLK => CLK,
          DATA_IN => DATA_IN,
          SHIFT => SHIFT,
          RX_DONE => RX_DONE,
          DATA_OUT => DATA_OUT
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
