--------------------------------------------------------------------------------
-- Company: 		Engs 31 14X
-- Engineer:		Daniel Whitcomb & Richard Cornew
--
-- Create Date:   16:45:22 07/05/2013
-- Design Name:   
-- Module Name:   Lab 3 TestBench
-- Project Name:  lab3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: TBIRD
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revised 3 July 2014 (EWH), for the Nexys3 board
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
 
ENTITY lab3_tb IS
END lab3_tb;
 
ARCHITECTURE behavior OF lab3_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT TBIRD
    PORT(
         clk : IN  std_logic;
         LeftTurn : IN  std_logic;
         RightTurn : IN  std_logic;
         Hazard : IN  std_logic;
         Brake : IN  std_logic;
         LC : OUT  std_logic;
         LB : OUT  std_logic;
         LA : OUT  std_logic;
         RA : OUT  std_logic;
         RB : OUT  std_logic;
         RC : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal LeftTurn : std_logic := '0';
   signal RightTurn : std_logic := '0';
   signal Hazard : std_logic := '0';
   signal Brake : std_logic := '0';

 	--Outputs
   signal LC : std_logic;
   signal LB : std_logic;
   signal LA : std_logic;
   signal RA : std_logic;
   signal RB : std_logic;
   signal RC : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;		-- 100 MHz
   
   -- For practical simulation, the slow clock divider inside the UUT must 
   -- be sped up to 10 * the master clock period.
   constant slow_clk_period : time := 10 * clk_period;
	
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: TBIRD PORT MAP (
          clk => clk,				
          LeftTurn => LeftTurn,
          RightTurn => RightTurn,
          Hazard => Hazard,
          Brake => Brake,
          LC => LC,
          LB => LB,
          LA => LA,
          RA => RA,
          RB => RB,
          RC => RC
        );

   -- Clock process definitions
   clk_100MHz_process :process
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
      wait for slow_clk_period;
      
      -- insert stimulus here 
		LeftTurn <= '1';
		wait for 2 * slow_clk_period;		
		
		LeftTurn <= '0';
		wait for 2 * slow_clk_period;
		RightTurn <= '1';
		wait for 2 * slow_clk_period;
		
		Hazard <= '1';
		wait for 2 * slow_clk_period;
		
		Hazard <= '0';
		RightTurn <= '0';
		wait for slow_clk_period;
		
		LeftTurn <= '1';
		wait for 2 * slow_clk_period;
		
		Hazard <= '1';
		wait for 2 * slow_clk_period;
		
		Hazard <= '0';
		LeftTurn <= '0';
		wait for slow_clk_period;
		
		RightTurn <= '1';
		wait for slow_clk_period;
		Brake <= '1';
		wait for 2 * slow_clk_period;
		
		RightTurn <= '0';
		Brake <= '0';
		wait for slow_clk_period;

		Brake <= '1';
		LeftTurn <= '1';
		wait for 2 * slow_clk_period;
		
		Brake <='0';
		LeftTurn <='0';
		wait for slow_clk_period;
		
		Brake <= '1';
		Hazard <= '1';
		wait for 2 * slow_clk_period;
		
      wait;
   end process;

END;