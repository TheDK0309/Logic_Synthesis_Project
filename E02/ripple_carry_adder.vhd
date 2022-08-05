-- TODO: Add VHDL Header here (in Emacs use: VHDL->Template->Insert Header )
--       Use your group number and name(s) of the group member(s)
--       in the 'author' field
--       Testbench has an example what a good header should look like

-------------------------------------------------------------------------------
-- Title      : TKT-1212, Exercise 02
-- Project    : 
-------------------------------------------------------------------------------
-- File       : tb_ripple_carry_adder.vhd
-- Author     : Le Do, Thong Nguyen
-- Company    : Tampere University
-- Created    : 2020-11-02
-- Platform   : 
-- Standard   : VHDL'87
-------------------------------------------------------------------------------
-- Description: Tests all combinations of summing two 3-bit values
-------------------------------------------------------------------------------
-- Copyright (c) 2008 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-11-02  1.0      ege     Created
-------------------------------------------------------------------------------


-- TODO: Add library called ieee here
--       And use package called std_logic_1164 from the library
library ieee;
use ieee.std_logic_1164.all;

-- TODO: Declare entity here
-- Name: ripple_carry_adder
-- No generics yet
-- Ports: a_in  3-bit std_logic_vector
--        b_in  3-bit std_logic_vector
--        s_out 4-bit std_logic_vector
entity ripple_carry_adder is
	port(
		a_in: in std_logic_vector (2 downto 0);
		b_in: in std_logic_vector (2 downto 0);
		s_out: out std_logic_vector (3 downto 0)
	);
end ripple_carry_adder;
-------------------------------------------------------------------------------

-- Architecture called 'gate' is already defined. Just fill it.
-- Architecture defines an implementation for an entity
architecture gate of ripple_carry_adder is

  -- TODO: Add your internal signal declarations here
	signal carry_ha, C, D, E, carry_fa , F, G, H : std_logic;
begin  -- gate

  -- TODO: Add signal assignments here
  -- x(0) <= y and z(2);
  -- Remember that VHDL signal assignments happen in parallel
  -- Don't use processes
  -- Computing the first half adder
	s_out(0) <= a_in(0) xor b_in(0);
	carry_ha <= a_in(0) and b_in(0);
  -- Computing the first Full adder
	C <= a_in(1) xor b_in(1);
	s_out(1) <= C xor carry_ha;
	D <= C and carry_ha;
	E <= a_in(1) and b_in(1);
	carry_fa <=D or E;
  -- Computing the second Full adder
	F <= a_in(2) xor b_in(2);
	s_out(2) <= F xor carry_fa;
	G <=carry_fa and F;
	H <= a_in(2) and b_in(2);
	s_out(3) <= G or H;
end gate;