--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:16:17 07/16/2014
-- Design Name:   
-- Module Name:   /home/danrwhitcomb/Documents/Lab4_stopwatch/StopWatch_tb.vhd
-- Project Name:  Lab4_stopwatch
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Stopwatch
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
 
ENTITY StopWatch_tb IS
END StopWatch_tb;
 
ARCHITECTURE behavior OF StopWatch_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Stopwatch
    PORT(
         clk : IN  std_logic;
         button : IN  std_logic;
         segments : OUT  std_logic_vector(6 downto 0);
         anodes : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal button : std_logic := '0';


 	--Outputs
   signal segments : std_logic_vector(6 downto 0);
   signal anodes : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Stopwatch PORT MAP (
          clk => clk,
          button => button,
          segments => segments,
          anodes => anodes
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
		button <= '1';
		wait for 500* clk_period;
		button <= '0';
		
		wait for 100*clk_period;
		button <= '1';
		wait for 300* clk_period;
		button <= '0';
		
		wait for 100*clk_period;
		button <= '1';
		wait for 300* clk_period;
		button <= '0';
		
		wait for 100*clk_period;
		button <= '1';
		wait for 300* clk_period;
		button <= '0';

      wait;
		
   end process;

END;
