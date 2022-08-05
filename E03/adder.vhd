-------------------------------------------------------------------------------
-- Title      : TKT-1212, Exercise 03
-- Project    : 
-------------------------------------------------------------------------------
-- File       : adder.vhd
-- Author     : Le Do, Thong Nguyen
-- Company    : Tampere University
-- Created    : 2020-11-02
-- Platform   : 
-- Standard   : VHDL'87
-------------------------------------------------------------------------------
-- Description: Tests all combinations of summing two 8-bit values
-------------------------------------------------------------------------------
-- Copyright (c) 2008 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-11-02  1.0      ege     Created
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is
	generic(
		operand_width_g:integer
	);
	port(
		clk: in std_logic;
		rst_n: in std_logic;
		a_in: in std_logic_vector (operand_width_g-1 downto 0);
		b_in: in std_logic_vector (operand_width_g-1 downto 0);
		sum_out: out std_logic_vector (operand_width_g+1-1 downto 0)
	);
end adder;
architecture rtl of adder is
	--define the signal with type signed
	signal a: signed(operand_width_g+1-1 downto 0);
begin
	--connect the signal to output and type conversation
	sum_out<=std_logic_vector(a);
	process (clk, rst_n)
	begin
		--reset register a at active-low-signal
		if(rst_n='0') then
			a <= (others => '0');
		--sum a_in and b_in when rising clock edge
		elsif (clk'EVENT AND clk = '1') then
			a<=resize(signed(a_in), operand_width_g+1) + resize(signed(b_in), operand_width_g+1);
			
		end if;
	end process;
end rtl;
