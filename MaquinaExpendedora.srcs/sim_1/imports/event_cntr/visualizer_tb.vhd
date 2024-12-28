--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:19:25 11/22/2019
-- Design Name:   
-- Module Name:   C:/Users/lcastedo/Documents/etsidi/docencia/Plan2010/grado/sed/2019-2020/pruebas/event_cntr/visualizer_tb.vhd
-- Project Name:  event_cntr
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: VISUALIZER
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;

use work.common.all;

entity VISUALIZER_TB is
end VISUALIZER_TB;
 
architecture TEST of VISUALIZER_TB is 

  constant visualizer_digits : positive :=    8;
  constant refresh_rate      : positive :=   30;
  constant test_clock_freq   : positive := 1200;

  -- Component Declaration for the Unit Under Test (UUT)
  component VISUALIZER
    generic
    (
      DIGITS     : positive;
      RFRSH_RATE : positive;
      CLK_FREQ   : positive
    );
    port (
      RESET_N    : in  std_logic;
      CLK        : in  std_logic;
      BCD_IN     : in  bcd_vector(DIGITS - 1 downto 0);
      SEGMNTS_N  : out std_logic_vector(7 downto 0);
      DIGITS_N   : out std_logic_vector(7 downto 0)
    );
  end component;
    
  --Inputs
  signal reset_n : std_logic;
  signal clk     : std_logic;
  signal bcd_in  : bcd_vector(visualizer_digits - 1 downto 0) :=
    (X"0", X"1", X"2", X"3", X"4", X"5", X"6", X"7");

  --Outputs
  signal segmnts_n : std_logic_vector(7 downto 0);
  signal digits_n  : std_logic_vector(7 downto 0);

  -- Clock period definitions
  constant clk_period : time := 1 sec / test_clock_freq;

begin
 
  -- Instantiate the Unit Under Test (UUT)
  uut: VISUALIZER
    generic map (
      DIGITS     => visualizer_digits,
      RFRSH_RATE => refresh_rate,
      CLK_FREQ   => test_clock_freq
    )
    port map (
      RESET_N   => reset_n,
      CLK       => clk,
      BCD_IN    => bcd_in,
      SEGMNTS_N => segmnts_n,
      DIGITS_N  => digits_n
    );

  -- Clock process definitions
  clk_process :process
  begin
    clk <= '0';
    wait for 0.5 * clk_period;
    clk <= '1';
    wait for 0.5 * clk_period;
  end process;

  -- Reset pulse
  reset_n <= '0' after 0.25 * clk_period, '1' after 0.75 * clk_period;

  -- Stimulus process
  stim_proc: process
  begin
    wait for 2 sec / refresh_rate;

    wait for 0.25 * clk_period;
    assert false
      report "[SUCCESS]: simulation finished."
      severity failure;
  end process;

end;
