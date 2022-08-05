-------------------------------------------------------------------------------
-- Title      : TKT-1212, Exercise 05
-- Project    : 
-------------------------------------------------------------------------------
-- File       : multi_port_adder.vhd
-- Author     : Le Do, Thong Nguyen
-- Company    : Tampere University
-- Created    : 2020-11-02
-- Platform   : 
-- Standard   : VHDL'87
-------------------------------------------------------------------------------
-- Description: create multiport_adder
-------------------------------------------------------------------------------
-- Copyright (c) 2008 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-11-13  1.0      ege     Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity multi_port_adder is

	generic (
		operand_width_g   : integer := 16;  
		num_of_operands_g : integer := 4); 

	port (
		clk         : in  std_logic;        
		rst_n       : in  std_logic;        
		operands_in : in  std_logic_vector(((operand_width_g * num_of_operands_g) - 1) downto 0);  
		sum_out     : out std_logic_vector((operand_width_g - 1) downto 0)  
	);

end multi_port_adder;

architecture structural of multi_port_adder is
	component adder
		generic (
			operand_width_g : integer);       
		port (

			clk     : in  std_logic;          
			rst_n   : in  std_logic;          
			a_in    : in  std_logic_vector((operand_width_g - 1) downto 0);  
			b_in    : in  std_logic_vector((operand_width_g - 1) downto 0);  
			sum_out : out std_logic_vector(operand_width_g  downto 0));  
    end component;

	type a_array is array(((num_of_operands_g/2) - 1) downto 0) of std_logic_vector(operand_width_g downto 0);  

	signal subtotal : a_array;           
	signal total    : std_logic_vector((operand_width_g + 1) downto 0);  

	begin  
		adder_1 : adder
			generic map (
			  operand_width_g => operand_width_g)
			port map (
				clk             => clk,
				rst_n           => rst_n,
				a_in            => operands_in((operand_width_g - 1) downto 0),
				b_in            => operands_in(((operand_width_g * 2) - 1) downto operand_width_g),
				sum_out         => subtotal(0));

		adder_2 : adder
			generic map (
				operand_width_g => operand_width_g)
			port map (
				clk             => clk,
				rst_n           => rst_n,
				a_in            => operands_in(((operand_width_g * 3) - 1) downto (operand_width_g * 2)),
				b_in            => operands_in(((operand_width_g * 4) - 1) downto (operand_width_g * 3)),
				sum_out         => subtotal(1));

		adder_3 : adder
			generic map (
				operand_width_g => (operand_width_g + 1))
			port map (
				clk             => clk,
				rst_n           => rst_n,
				a_in            => subtotal(0),
				b_in            => subtotal(1),
				sum_out         => total);
		sum_out <= total((operand_width_g - 1) downto 0);
		assert (num_of_operands_g = 4) report "severity failure  -- num_of_operands_g not equal to 4" severity failure;
end structural;