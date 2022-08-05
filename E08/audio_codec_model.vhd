-------------------------------------------------------------------------------
-- Title      : TKT-1212, Exercise 08
-- Project    : 
-------------------------------------------------------------------------------
-- File       : audio_codec_model.vhd
-- Author     : Le Do, Thong Nguyen
-- Company    : Tampere University
-- Created    : 2021-18-01
-- Platform   : 
-- Standard   : VHDL'87
-------------------------------------------------------------------------------
-- Description: a model implementation for the codec
-------------------------------------------------------------------------------
-- Copyright (c) 2021 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity audio_codec_model is
	generic(
		data_width_g : integer := 16
	);
	port(
		rst_n                           : in  std_logic;
		aud_bclk_in                     : in  std_logic;
		aud_lrclk_in                    : in  std_logic;
		aud_data_in                     : in  std_logic;
		value_left_out				    : out std_logic_vector(data_width_g - 1 downto 0);
		value_right_out					: out std_logic_vector(data_width_g - 1 downto 0)
	);
end entity audio_codec_model;

architecture RTL of audio_codec_model is

	type state_type is (wait_for_input, read_left, read_right);										-- Declared each state of state machine
	signal curr_state_r : state_type;																-- Register to store the current state
	signal next_state : state_type;																	-- Register to store the next state
	
	signal counter : integer := 0;																	-- Count to assign correctly the position of bit in value_out register

	signal value_left_out_r, value_right_out_r : std_logic_vector(data_width_g - 1 downto 0);

begin
	state_machine : process(curr_state_r, aud_lrclk_in)
	
	-- process to deicde which state to go in next clk
	-- State is decided based on aud_lrclk_in signal
	-- if aud_lclk_in = 1, next state is read_left
	-- if aud_lclk_in = 0, next state is wait_for_input or read_right
	
	begin
	
		case curr_state_r is
			when wait_for_input =>
				if aud_lrclk_in = '1' then
					next_state <= read_left;
				else
					next_state <= wait_for_input;
				end if;
				
			when read_left =>
				if aud_lrclk_in = '0' then
					next_state <= read_right;
				else
					next_state <= read_left;
				end if;
				
			when read_right =>
				if aud_lrclk_in = '1' then
					next_state <= read_left;
				else
					next_state <= read_right;
				end if;
			
				when others =>
				next_state <= wait_for_input;  
		end case;
	
	end process state_machine;

	sync_ps: process (aud_bclk_in, rst_n)
	begin  
	
		if rst_n = '0' then									-- reset state_machine and other registers or signal
		
		    curr_state_r <= wait_for_input;
			counter <= 0;
			value_right_out_r <= (others => '0');
			value_left_out_r <= (others => '0');
			value_left_out <= (others => '0');
			value_right_out <= (others => '0');
			
		elsif aud_bclk_in'event and aud_bclk_in = '0' then
		
			curr_state_r <= next_state;						-- when failing clk, changing state to advoid to lose the bit incoming during the transition.
			
			if counter = (data_width_g - 1) then			-- if counter reach to the maximum value of data width, reset counter 
															-- set output with respective register which is based on current state 
				counter <= 0;
				
				if curr_state_r = read_left then
				
				value_right_out <= value_right_out_r;
				value_right_out_r <= (others => '0');
				
				elsif curr_state_r = read_right then
				
				value_left_out <= value_left_out_r;
				value_left_out_r <= (others => '0');
				
				else
				
				value_left_out <= (others => '0');			-- if current state is not left or right, reset both output signals.
				value_right_out <= (others => '0');
				
				end if;

			else
			
			counter <= counter + 1; 						-- increase counter if it still not reach to the maximum
			
			end if;
			
			-- Set aud_data_in into correct postion in each side registers.
			
			if next_state = read_right then
			
				value_left_out_r((data_width_g - counter) - 1) <= aud_data_in;
				
			elsif next_state = read_left then
			
				value_right_out_r((data_width_g - counter) - 1) <= aud_data_in;
				
			else
		
				value_right_out_r <= (others => '0');		-- reset value out register if there is not right or left state.
				value_left_out_r <= (others => '0');
				 
			end if;
    
		end if;
	
	end process sync_ps;
	
end architecture RTL;
