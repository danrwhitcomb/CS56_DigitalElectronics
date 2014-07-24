--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:31:11 07/16/2014
-- Design Name:   
-- Module Name:   /home/danrwhitcomb/Documents/Lab3/StopWatchController_tb.vhd
-- Project Name:  Lab3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: StopWatchController
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
 
ENTITY StopWatchController_tb IS
END StopWatchController_tb;
 
ARCHITECTURE behavior OF StopWatchController_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT StopWatchController
    PORT(
         BUTTON : IN  std_logic;
         clk : IN  std_logic;
         Q : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal BUTTON : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal Q : std_logic_vector(1 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: StopWatchController PORT MAP (
          BUTTON => BUTTON,
          clk => clk,
          Q => Q
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 
		-- First press
		BUTTON <= '1';
		wait for 2* clk_period;
		BUTTON <= '0';
		wait for 3* clk_period;
		
		--Second press
		BUTTON <= '1';
		wait for 2* clk_period;
		BUTTON <= '0';
		wait for 3* clk_period;
		
		--Third Press
		BUTTON <= '1';
		wait for 2* clk_period;
		BUTTON <= '0';
		wait for 3* clk_period;
		
		-- Fourth Press
		BUTTON <= '1';
		wait for 2* clk_period;
		BUTTON <= '0';
		wait for 3* clk_period;
		
      wait;
   end process;

END;
