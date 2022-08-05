-------------------------------------------------------------------------------
-- Title      : TKT-1212, Exercise 05
-- Project    : 
-------------------------------------------------------------------------------
-- File       : wave_gen.vhd
-- Author     : Le Do, Thong Nguyen
-- Company    : Tampere University
-- Created    : 2020-11-02
-- Platform   : 
-- Standard   : VHDL'87
-------------------------------------------------------------------------------
-- Description: Triangular wave generator 
-------------------------------------------------------------------------------
-- Copyright (c) 2008 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-12-03  1.0      ege     Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity wave_gen is

  generic (
    width_g : integer;                  
    step_g  : integer);                 

  port (
    clk           		: in  std_logic;      											--clock signal
    rst_n         		: in  std_logic;      											--reset
    sync_clear_n_in 	: in  std_logic;    											--wave_gen reset signal  
    value_out     		: out std_logic_vector((width_g - 1) downto 0));  				--output with width width_g

end wave_gen;

architecture wave of wave_gen is

  constant max_value_c : integer := ((((2 ** (width_g - 1)) - 1) / step_g) * step_g);   -- max value of counter
  constant upwards_c : std_logic := '1';  												-- assign a flag value for upwards trend of wave
  
  signal direction_r           	 : std_logic;											-- register to store the direction of the wave
  signal current_value_r 		 : signed((width_g - 1) downto 0);  					-- register to store the wave value

begin  

  counter_process : process (clk, rst_n)

  begin  
    if rst_n = '0' then                 

      current_value_r <= (others => '0');   -- reset the current value of wave when reset
	  direction_r <= upwards_c;
	  
    elsif clk'event and clk = '1' then  -- rising clock edge
	
	-- if sync_clear_in is raised then the counter and signals are reset.
      if sync_clear_n_in = '0' then
	  
        current_value_r <= (others => '0');
        direction_r     <= upwards_c;

      else
        if (to_integer(current_value_r) = max_value_c - step_g and direction_r = upwards_c) then				-- If current direction is upwards and next step leads to max value,
          direction_r <= not upwards_c;																		-- then change the direction.
        elsif (to_integer(current_value_r) = - max_value_c + step_g and direction_r = not upwards_c) then		-- or current directionn is downwards and next step leads to min value,
          direction_r <= upwards_c;																			-- then change the direction.
        end if;
        
        if (direction_r = upwards_c) then
          current_value_r <= current_value_r + step_g;						-- increase current value if current direction is upwards
        else
          current_value_r <= current_value_r - step_g;						-- decrease current value if current direction is downwards
        end if;

	  end if;
    end if;
  end process counter_process;
	-- places the current_value_r signal at the output
  value_out <= std_logic_vector(current_value_r);

end wave;