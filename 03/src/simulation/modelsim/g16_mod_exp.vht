-- Copyright (C) 2020  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "03/21/2022 16:09:24"
                                                            
-- Vhdl Test Bench template for design  :  g16_mod_exp
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY g16_mod_exp_vhd_tst IS
END g16_mod_exp_vhd_tst;
ARCHITECTURE g16_mod_exp_arch OF g16_mod_exp_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL c : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL clk : STD_LOGIC;
SIGNAL d : STD_LOGIC_VECTOR(13 DOWNTO 0);
SIGNAL ready : STD_LOGIC;
SIGNAL reset : STD_LOGIC;
SIGNAL s : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL start : STD_LOGIC;
COMPONENT g16_mod_exp
	PORT (
	c : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
	clk : IN STD_LOGIC;
	d : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
	ready : OUT STD_LOGIC;
	reset : IN STD_LOGIC;
	s : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	start : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : g16_mod_exp
	PORT MAP (
-- list connections between master ports and signals
	c => c,
	clk => clk,
	d => d,
	ready => ready,
	reset => reset,
	s => s,
	start => start
	);
init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once                      
WAIT;                                                       
END PROCESS init;                                           
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
	
WAIT;                                                        
END PROCESS always;                                          
END g16_mod_exp_arch;
