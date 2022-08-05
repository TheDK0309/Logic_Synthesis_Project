-------------------------------------------------------------------------------
-- Title      : TKT-1212, Exercise 05
-- Project    : 
-------------------------------------------------------------------------------
-- File       : tb_multi_port_adder.vhd
-- Author     : Le Do, Thong Nguyen
-- Company    : Tampere University
-- Created    : 2020-11-02
-- Platform   : 
-- Standard   : VHDL'87
-------------------------------------------------------------------------------
-- Description: testbench for multiport_adder
-------------------------------------------------------------------------------
-- Copyright (c) 2008 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-11-20  1.0      ege     Created
-------------------------------------------------------------------------------

--define libraries
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

--entity of tb_multi_port_adder
entity tb_multi_port_adder is
	generic (
		operand_width_g : integer := 3);   --operand_width_g with default value 3 
end tb_multi_port_adder;

architecture testbench of tb_multi_port_adder is
	constant clk_period_c      : time    := 10 ns;  --standard clork cycle 
	constant operand_num_c : integer := 4;  --number of operand
	constant DUV_delay_c       : integer := 2;   --DUV delay 

	signal clk            : std_logic := '0';  --clock signal with initial value of 0
	signal rst_n          : std_logic := '0';  --reset signal with initial value of 0
	signal output_valid_r : std_logic_vector(DUV_delay_c downto 0); --
	signal operands_r     : std_logic_vector(((operand_width_g * operand_num_c) - 1) downto 0);  
	signal sum            : std_logic_vector(operand_width_g-1 downto 0);  

	--reading from file input.txt,ref_results_4b.txt and writing result to output.txt
	file input_f       : text open read_mode is "input.txt";  
	file ref_results_f : text open read_mode is "ref_results.txt";  
	file output_f      : text open write_mode is "output.txt";  
  
	--creat component multi_port_adder
	component multi_port_adder
		generic (
		  operand_width_g   :     integer; 
		  num_of_operands_g :     integer); 
		port (
		  clk               : in  std_logic; 
		  rst_n             : in  std_logic;  
		  operands_in       : in  std_logic_vector(((operand_width_g * num_of_operands_g) - 1) downto 0); 
		  sum_out           : out std_logic_vector((operand_width_g - 1) downto 0));  --sumout with size of 15 downto 0
	end component;

	begin 
		-- assign not clk after clk_period_c / 2
		clock_gen : process (clk)
		begin  
			clk <= not clk after (clk_period_c / 2);
		end process clock_gen;
		-- Raise the reset up after 4 clock cycles
		rst_n <= '1' after (clk_period_c * 4);

		DUV : multi_port_adder
			generic map (
				operand_width_g   => (operand_width_g),
				num_of_operands_g => operand_num_c)
			port map (
				clk               => clk,
				rst_n             => rst_n,
				operands_in       => operands_r,
				sum_out           => sum);
		--process for reading input files
		input_reader : process (clk, rst_n)
			variable line_v  : line;       -- variable for one line    
			type int_array is array ((operand_num_c - 1) downto 0) of integer; --array of integer of 4 numbers
			variable integer_variable_v : int_array;  
		begin  
			if rst_n = '0' then  
				--- reset operands_r and output_valid_r to 0
				operands_r     <= (others => '0');
				output_valid_r <= (others => '0');
			elsif clk'event and clk = '1' then   --risng clock edge 
				output_valid_r <= output_valid_r((DUV_delay_c - 1) downto 0) & '1'; --set lsb to 1 and left shift
				if (not endfile(input_f)) then --if the end of the file is not reached
					readline(input_f, line_v);  --read lines of input.txt
					for i in (operand_num_c - 1) downto 0 loop
						read(line_v, integer_variable_v(i)); --read one value from a line
						--Assign the values to the multiport adders' inputs to signal operands_r
						operands_r(((operand_width_g * (i + 1)) - 1) downto (operand_width_g * i)) <= std_logic_vector(to_signed(integer_variable_v(i), operand_width_g));
					end loop;
				end if;
			end if;
		end process input_reader;
		checker : process (clk, rst_n)
			variable in_line      : line;    --input line
			variable result        : integer;  --result
			variable out_line : line;     --output line
		begin  
			if rst_n = '0' then  
				--sum <= (others => '0');
			elsif clk'event and clk = '1' then 
				if output_valid_r(DUV_delay_c) = '1' then
					if (not endfile(ref_results_f)) then  --if end of the file not reached
						-- Read line and line value from the scan file
						readline(ref_results_f, in_line); 
						read(in_line, result);
						
						-- Check whether the calculated value corresponds to the read value. If not
						-- throw the Assert and inform the tester.
						assert ((to_integer(signed(sum))) = result) report "Value is not equal to reference value!" severity error;
						-- Write the calculated value to the output.txt file
						write(out_line, (to_integer(signed(sum))));
						writeline(output_f, out_line);
					else
						-- If the simulation passes successfully, its completion will be announced
						assert false report "Simulation done!" severity failure;
					end if;
				end if;
			end if;
		end process checker;
end testbench;