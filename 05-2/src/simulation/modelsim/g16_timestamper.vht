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
-- Generated on "04/09/2022 00:07:21"
                                                            
-- Vhdl Test Bench template for design  :  g16_timestamper
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;                                

ENTITY g16_timestamper_vhd_tst IS
END g16_timestamper_vhd_tst;
ARCHITECTURE g16_timestamper_arch OF g16_timestamper_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clk : STD_LOGIC;
SIGNAL enable : STD_LOGIC;
SIGNAL message : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL rst : STD_LOGIC;
SIGNAL signature : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL timestamp : STD_LOGIC_VECTOR(21 DOWNTO 0);
COMPONENT g16_timestamper
	PORT (
	clk : IN STD_LOGIC;
	enable : IN STD_LOGIC;
	message : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	rst : IN STD_LOGIC;
	signature : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	timestamp : IN STD_LOGIC_VECTOR(21 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : g16_timestamper
	PORT MAP (
-- list connections between master ports and signals
	clk => clk,
	enable => enable,
	message => message,
	rst => rst,
	signature => signature,
	timestamp => timestamp
	);

	-- clock generation
	clk_process: process
	begin
		clk <= '0';
		wait for 1 ns;
		clk <= '1';
		wait for 1 ns;
	end process clk_process;
	
	-- test process
	always: process
	begin
		rst <= '1';
		enable <= '1';
		-- time is 2022/04/08 5:00PM, which is 195209 hours after 2000
		timestamp <= STD_LOGIC_VECTOR(TO_UNSIGNED(195209, 22));
		message <= STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32));
		wait for 10 ns;
		-- start reading message: expected signature 22194
		-- message chunk 1
		rst <= '0';
		message <= STD_LOGIC_VECTOR(TO_UNSIGNED(123, 32));
		wait for 2 ns;
		-- message chunk 2
		message <= STD_LOGIC_VECTOR(TO_UNSIGNED(456, 32));
		wait for 2 ns;
		-- finish reading
		enable <= '0';
		wait for 300 us;
		
		-- reset
		rst <= '1';
		enable <= '1';
		wait for 10 ns;
		-- start reading message: expected signature 5059
		-- message chunk 1
		rst <= '0';
		message <= STD_LOGIC_VECTOR(TO_UNSIGNED(2776, 32));
		wait for 2 ns;
		-- message chunk 2
		message <= STD_LOGIC_VECTOR(TO_UNSIGNED(123456, 32));
		wait for 2 ns;
		-- message chunk 3
		message <= STD_LOGIC_VECTOR(TO_UNSIGNED(987, 32));
		wait for 2 ns;
		-- finish reading
		enable <= '0';
		wait for 300 us;
		
		-- reset
		rst <= '1';
		enable <= '1';
		wait for 10 ns;
		-- start reading message: expected signature 14476
		-- message chunk 1
		rst <= '0';
		message <= STD_LOGIC_VECTOR(TO_UNSIGNED(463758, 32));
		wait for 2 ns;
		-- message chunk 2
		message <= STD_LOGIC_VECTOR(TO_UNSIGNED(44401, 32));
		wait for 2 ns;
		-- message chunk 3
		message <= STD_LOGIC_VECTOR(TO_UNSIGNED(9667412, 32));
		wait for 2 ns;
		-- finish reading
		enable <= '0';
		wait for 300 us;
		
	wait;
	end process always;
	
END g16_timestamper_arch;
