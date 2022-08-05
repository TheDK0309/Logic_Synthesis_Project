-------------------------------------------------------------------------------
-- Title      : TKT-1212, Exercise 08
-- Project    : 
-------------------------------------------------------------------------------
-- File       : tb_audio_ctrl.vhd
-- Author     : Le Do, Thong Nguyen
-- Company    : Tampere University
-- Created    : 2021-14-01
-- Platform   : 
-- Standard   : VHDL'87
-------------------------------------------------------------------------------
-- Description: the controller generates two oscillating signals (clock signals to DA7212 codec)
-- : aud_bclk_out and aud_lrclk_out 
-------------------------------------------------------------------------------
-- Copyright (c) 2021 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity audio_ctrl is
	generic(
		ref_clk_freq_g : integer := 12288000;
		sample_rate_g  : integer := 48000;
		data_width_g   : integer := 16
	);
	port(
		clk                         : in  std_logic;
		rst_n                       : in  std_logic;
		left_data_in, right_data_in : in  std_logic_vector(data_width_g - 1 downto 0);
		aud_bclk_out                : out std_logic;
		aud_lrclk_out               : out std_logic;
		aud_data_out                : out std_logic
	);
end entity audio_ctrl;

architecture RTL of audio_ctrl is

	constant lrclk_counter_steps_c : integer := ref_clk_freq_g / sample_rate_g / 2; 			-- lrclk frequency is same as sampling frequency.

	constant bclk_counter_steps_c : integer := lrclk_counter_steps_c / data_width_g / 2;		-- Calculate number of steps of bclk counter, by divide lrclk by 2,
																								-- every bit now will can be transmitted on one half period																							
	-- Counters for generated clocks.
	signal bclk_counter_r  : integer range 0 to bclk_counter_steps_c - 1;
	signal lrclk_counter_r : integer range 0 to lrclk_counter_steps_c - 1;
																								
	signal left_sample_r, right_sample_r : std_logic_vector(data_width_g - 1 downto 0);			-- Registers for samples and currently transmitted bit index.
	signal bit_index_r                   : integer range -1 to data_width_g - 1;

	-- Registers for outputs
	signal bclk_r, lrclk_r, data_out_r : std_logic;
	
begin
	sync : process(clk, rst_n)

	begin
		if (rst_n = '0') then
		
			bclk_r          <= '0';
			lrclk_r         <= '0';
			data_out_r      <= '0';
			left_sample_r   <= (others => '0');
			right_sample_r  <= (others => '0');
			bclk_counter_r  <= 0;
			lrclk_counter_r <= 0;
			bit_index_r     <= data_width_g - 1;
			
		elsif (clk'event and clk = '1') then

			-- Generate bclk
			if (bclk_counter_r /= bclk_counter_steps_c - 1) then
			
				bclk_counter_r <= bclk_counter_r + 1;
				
			else
			
				bclk_counter_r <= 0;
				bclk_r         <= not bclk_r;
				
				-- Transmit next bit on rising edge of bclk if whole word isn't transmitted yet.
				if (bclk_r = '0' and bit_index_r /= -1) then
				
					if (lrclk_counter_r = lrclk_counter_steps_c - 1) then
						-- lrclk changes state in this clock cycle. Registered lrclk_r does not changed yet.
						if (lrclk_r = '0') then
						
							-- Data must be outputted directly eventhought sample registers cannot be used at this stage.
							data_out_r  <= left_data_in(bit_index_r);
							
						else
						
							data_out_r  <= right_data_in(bit_index_r);
							
						end if;
					else
						--  output correct sample register if lrclk does not change state in this clock cycle.
						if (lrclk_r = '1') then
						
							data_out_r  <= left_sample_r(bit_index_r);
							
						else
						
							data_out_r  <= right_sample_r(bit_index_r);
							
						end if;
					end if;
			
					bit_index_r <= bit_index_r - 1;
					
				end if;

			end if;

			-- Generate lrclk
			if (lrclk_counter_r /= lrclk_counter_steps_c - 1) then
			
				lrclk_counter_r <= lrclk_counter_r + 1;
				
			else -- Reset the bit clock in case the lrclk counter is not divisible by bit clock step count.
			
				lrclk_r         <= not lrclk_r;
				lrclk_counter_r <= 0;
				bclk_counter_r  <= 0;
				bclk_r          <= '0';		
				bit_index_r    <= data_width_g - 1;
				
				-- Read samples on rising edge of the lrclk.
				if (lrclk_r = '0') then
				
					left_sample_r  <= left_data_in;
					right_sample_r <= right_data_in;
					
				end if;
			end if;

		end if;
	end process;

	aud_bclk_out  <= bclk_r;
	aud_lrclk_out <= lrclk_r;
	aud_data_out  <= data_out_r;
	
end architecture RTL;
