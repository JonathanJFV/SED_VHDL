
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DINERO_TB1 is
--  Port ( );
end DINERO_TB1;

architecture bench of DINERO_TB1 is

component DINERO
      Port ( IN_1 : in STD_LOGIC;
             IN_2 : in STD_LOGIC;
             IN_3 : in STD_LOGIC;
             CE   : in STD_LOGIC;
             RST_N : in STD_LOGIC;
             CLK : in STD_LOGIC;
             DINERO : out unsigned (7 downto 0));
  end component;

  signal IN_1: STD_LOGIC := '0';
  signal IN_2: STD_LOGIC := '0';
  signal IN_3: STD_LOGIC := '0';
  signal CE: STD_LOGIC := '0';
  signal RST_N: STD_LOGIC := '1';
  signal CLK: STD_LOGIC := '0';
  signal DINEROO: unsigned (7 downto 0);

  constant clock_period: time := 10 ns;

begin

  uut: DINERO port map ( IN_1   => IN_1,
                         IN_2   => IN_2,
                         IN_3   => IN_3,
                         CE     => CE,
                         RST_N  => RST_N,
                         CLK    => CLK,
                         DINERO => DINEROO );

  -- Clock generation process
  clocking: process
  begin
    while true loop
      CLK <= '0';
      wait for clock_period / 2;
      CLK <= '1';
      wait for clock_period / 2;
    end loop;
  end process;

  stimulus: process
  begin
    -- Step 1: Initialize signals
    CE <= '0';         -- Disable counting
    RST_N <= '1';      -- Ensure reset is inactive
    wait for clock_period;

    -- Test case 1: IN_1 changes 3 times, IN_2 and IN_3 change once
    CE <= '1';         -- Enable counting
    IN_1 <= '1';       -- IN_1 changes first time
    wait for 2 * clock_period;
    IN_1 <= '0';
    wait for 2 * clock_period;
    IN_2 <= '1';       -- IN_1 changes second time
    wait for 2 * clock_period;
    IN_2 <= '0';
    wait for 2 * clock_period;
    IN_1 <= '1';       -- IN_1 changes third time
    wait for 2 * clock_period;

    CE <= '0';
    wait for 4 * clock_period;
    CE <= '1';

    IN_3 <= '1';       -- IN_1 changes first time
    wait for 2 * clock_period;
    IN_3 <= '0';
    wait for 2 * clock_period;
    IN_2 <= '1';       -- IN_1 changes second time
    wait for 2 * clock_period;
    IN_2 <= '0';
    wait for 2 * clock_period;

    -- Test case 2: Set CE to '0' and verify DINERO remains 0
    CE <= '0';
    wait for 4 * clock_period;

    -- Test case 3: Repeat test with IN_2 changing 2 times
    CE <= '1';
    IN_1 <= '0';       -- Ensure IN_1 is stable
    IN_2 <= '1';       -- IN_2 changes first time
    wait for 3 * clock_period;
    IN_2 <= '0';
    wait for 3 * clock_period;
    IN_2 <= '1';       -- IN_2 changes second time
    wait for 3 * clock_period;

    -- Test case 4: Verify reset functionality
    RST_N <= '0';      -- Activate reset
    wait for 2 * clock_period;
    RST_N <= '1';      -- Deactivate reset
    wait for 2 * clock_period;

    -- End simulation
    wait;
  end process;

end bench;
