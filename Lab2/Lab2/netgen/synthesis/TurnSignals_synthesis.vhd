--------------------------------------------------------------------------------
-- Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: P.49d
--  \   \         Application: netgen
--  /   /         Filename: TurnSignals_synthesis.vhd
-- /___/   /\     Timestamp: Tue Jul  8 01:25:02 2014
-- \   \  /  \ 
--  \___\/\___\
--             
-- Command	: -intstyle ise -ar Structure -tm TurnSignals -w -dir netgen/synthesis -ofmt vhdl -sim TurnSignals.ngc TurnSignals_synthesis.vhd 
-- Device	: xc3s500e-4-ft256
-- Input file	: TurnSignals.ngc
-- Output file	: /home/danrwhitcomb/Documents/Lab 2/Lab2/netgen/synthesis/TurnSignals_synthesis.vhd
-- # of Entities	: 1
-- Design Name	: TurnSignals
-- Xilinx	: /opt/Xilinx/14.4/ISE_DS/ISE/
--             
-- Purpose:    
--     This VHDL netlist is a verification model and uses simulation 
--     primitives which may not represent the true implementation of the 
--     device, however the netlist is functionally correct and should not 
--     be modified. This file cannot be synthesized and should only be used 
--     with supported simulation tools.
--             
-- Reference:  
--     Command Line Tools User Guide, Chapter 23
--     Synthesis and Simulation Design Guide, Chapter 6
--             
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
use UNISIM.VPKG.ALL;

entity TurnSignals is
  port (
    clk : in STD_LOGIC := 'X'; 
    RIGHT : in STD_LOGIC := 'X'; 
    LEFT : in STD_LOGIC := 'X'; 
    HAZ : in STD_LOGIC := 'X'; 
    lt : out STD_LOGIC_VECTOR ( 2 downto 0 ); 
    rt : out STD_LOGIC_VECTOR ( 2 downto 0 ) 
  );
end TurnSignals;

architecture Structure of TurnSignals is
  signal HAZ_IBUF_1 : STD_LOGIC; 
  signal LEFT_IBUF_3 : STD_LOGIC; 
  signal N4 : STD_LOGIC; 
  signal N6 : STD_LOGIC; 
  signal RIGHT_IBUF_7 : STD_LOGIC; 
  signal clk_BUFGP_9 : STD_LOGIC; 
  signal leftV_0_mux0000 : STD_LOGIC; 
  signal leftV_0_not0001_12 : STD_LOGIC; 
  signal leftV_1_mux0000 : STD_LOGIC; 
  signal leftV_1_not0001_15 : STD_LOGIC; 
  signal leftV_2_mux0001 : STD_LOGIC; 
  signal leftV_2_not0001 : STD_LOGIC; 
  signal rightV_0_mux0000 : STD_LOGIC; 
  signal rightV_0_not0001_24 : STD_LOGIC; 
  signal rightV_1_mux0000 : STD_LOGIC; 
  signal rightV_1_not0001_27 : STD_LOGIC; 
  signal rightV_2_mux0001 : STD_LOGIC; 
  signal rightV_2_not0001 : STD_LOGIC; 
  signal leftV : STD_LOGIC_VECTOR ( 2 downto 0 ); 
  signal rightV : STD_LOGIC_VECTOR ( 2 downto 0 ); 
begin
  rightV_2 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk_BUFGP_9,
      CE => rightV_2_not0001,
      D => rightV_2_mux0001,
      Q => rightV(2)
    );
  rightV_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk_BUFGP_9,
      CE => rightV_0_not0001_24,
      D => rightV_0_mux0000,
      Q => rightV(0)
    );
  rightV_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk_BUFGP_9,
      CE => rightV_1_not0001_27,
      D => rightV_1_mux0000,
      Q => rightV(1)
    );
  leftV_2 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk_BUFGP_9,
      CE => leftV_2_not0001,
      D => leftV_2_mux0001,
      Q => leftV(2)
    );
  leftV_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk_BUFGP_9,
      CE => leftV_0_not0001_12,
      D => leftV_0_mux0000,
      Q => leftV(0)
    );
  leftV_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => clk_BUFGP_9,
      CE => leftV_1_not0001_15,
      D => leftV_1_mux0000,
      Q => leftV(1)
    );
  rightV_2_mux00011 : LUT3
    generic map(
      INIT => X"0E"
    )
    port map (
      I0 => RIGHT_IBUF_7,
      I1 => HAZ_IBUF_1,
      I2 => rightV(2),
      O => rightV_2_mux0001
    );
  rightV_1_mux00001 : LUT3
    generic map(
      INIT => X"0E"
    )
    port map (
      I0 => RIGHT_IBUF_7,
      I1 => HAZ_IBUF_1,
      I2 => rightV(1),
      O => rightV_1_mux0000
    );
  rightV_0_mux00001 : LUT3
    generic map(
      INIT => X"0E"
    )
    port map (
      I0 => RIGHT_IBUF_7,
      I1 => HAZ_IBUF_1,
      I2 => rightV(0),
      O => rightV_0_mux0000
    );
  leftV_2_mux00011 : LUT3
    generic map(
      INIT => X"0E"
    )
    port map (
      I0 => LEFT_IBUF_3,
      I1 => HAZ_IBUF_1,
      I2 => leftV(2),
      O => leftV_2_mux0001
    );
  leftV_1_mux00001 : LUT3
    generic map(
      INIT => X"0E"
    )
    port map (
      I0 => LEFT_IBUF_3,
      I1 => HAZ_IBUF_1,
      I2 => leftV(1),
      O => leftV_1_mux0000
    );
  leftV_0_mux00001 : LUT3
    generic map(
      INIT => X"0E"
    )
    port map (
      I0 => LEFT_IBUF_3,
      I1 => HAZ_IBUF_1,
      I2 => leftV(0),
      O => leftV_0_mux0000
    );
  rightV_2_not00011 : LUT4
    generic map(
      INIT => X"FBBB"
    )
    port map (
      I0 => HAZ_IBUF_1,
      I1 => RIGHT_IBUF_7,
      I2 => rightV(1),
      I3 => rightV(0),
      O => rightV_2_not0001
    );
  leftV_2_not00011 : LUT4
    generic map(
      INIT => X"FBBB"
    )
    port map (
      I0 => HAZ_IBUF_1,
      I1 => LEFT_IBUF_3,
      I2 => leftV(1),
      I3 => leftV(0),
      O => leftV_2_not0001
    );
  rightV_0_not0001_SW0 : LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => HAZ_IBUF_1,
      I1 => RIGHT_IBUF_7,
      O => N4
    );
  rightV_0_not0001 : LUT4
    generic map(
      INIT => X"EFAF"
    )
    port map (
      I0 => N4,
      I1 => rightV(2),
      I2 => rightV(0),
      I3 => rightV(1),
      O => rightV_0_not0001_24
    );
  leftV_0_not0001_SW0 : LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => HAZ_IBUF_1,
      I1 => LEFT_IBUF_3,
      O => N6
    );
  leftV_0_not0001 : LUT4
    generic map(
      INIT => X"EFAF"
    )
    port map (
      I0 => N6,
      I1 => leftV(2),
      I2 => leftV(0),
      I3 => leftV(1),
      O => leftV_0_not0001_12
    );
  rightV_1_not0001 : LUT4
    generic map(
      INIT => X"EFAA"
    )
    port map (
      I0 => N4,
      I1 => rightV(2),
      I2 => rightV(1),
      I3 => rightV(0),
      O => rightV_1_not0001_27
    );
  leftV_1_not0001 : LUT4
    generic map(
      INIT => X"EFAA"
    )
    port map (
      I0 => N6,
      I1 => leftV(2),
      I2 => leftV(1),
      I3 => leftV(0),
      O => leftV_1_not0001_15
    );
  RIGHT_IBUF : IBUF
    port map (
      I => RIGHT,
      O => RIGHT_IBUF_7
    );
  LEFT_IBUF : IBUF
    port map (
      I => LEFT,
      O => LEFT_IBUF_3
    );
  HAZ_IBUF : IBUF
    port map (
      I => HAZ,
      O => HAZ_IBUF_1
    );
  lt_2_OBUF : OBUF
    port map (
      I => leftV(2),
      O => lt(2)
    );
  lt_1_OBUF : OBUF
    port map (
      I => leftV(1),
      O => lt(1)
    );
  lt_0_OBUF : OBUF
    port map (
      I => leftV(0),
      O => lt(0)
    );
  rt_2_OBUF : OBUF
    port map (
      I => rightV(2),
      O => rt(2)
    );
  rt_1_OBUF : OBUF
    port map (
      I => rightV(1),
      O => rt(1)
    );
  rt_0_OBUF : OBUF
    port map (
      I => rightV(0),
      O => rt(0)
    );
  clk_BUFGP : BUFGP
    port map (
      I => clk,
      O => clk_BUFGP_9
    );

end Structure;

