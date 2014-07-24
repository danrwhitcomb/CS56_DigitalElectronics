--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:23:50 07/15/2014
-- Design Name:   
-- Module Name:   /home/danrwhitcomb/Documents/Lab3/DecadeCounter_tb.vhd
-- Project Name:  Lab3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DecadeCounter
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
 
ENTITY DecadeCounter_tb IS
END DecadeCounter_tb;
 
ARCHITECTURE behavior OF DecadeCounter_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DecadeCounter
    PORT(
         EN_IN : IN  std_logic;
         CLEAR : IN  std_logic;
         clk : IN  std_logic;
         Q : OUT  std_logic_vector(3 downto 0);
         EN_OUT : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal EN_IN : std_logic := '0';
   signal CLEAR : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal Q : std_logic_vector(3 downto 0);
   signal EN_OUT : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DecadeCounter PORT MAP (
          EN_IN => EN_IN,
          CLEAR => CLEAR,
          clk => clk,
          Q => Q,
          EN_OUT => EN_OUT
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
		EN_IN <= '1';
		wait for clk_period*5;
		EN_IN <= '0';
		wait for clk_period*2;
		EN_IN <= '1';
		wait for clk_period*4;
		CLEAR <= '1';
		wait for clk_period;
		CLEAR <= '0';
		wait for clk_period*4;
		EN_IN <= '0';
		wait for clk_period;
		CLEAR <= '0';
      -- insert stimulus here 
		
      wait;
   end process;

END;
