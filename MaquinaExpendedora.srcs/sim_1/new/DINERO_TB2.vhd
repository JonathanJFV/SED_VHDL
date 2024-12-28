
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DINERO_TB2 is
--  Port ( );
end DINERO_TB2;

architecture bench of DINERO_TB2 is

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
  signal CE: STD_LOGIC := '1';
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
    -- Step 1: Generate 3 pulses for IN_1 and deactivate reset
    RST_N <= '1';          -- Ensure reset is inactive
    wait for clock_period;

    IN_1 <= '1';           -- Pulse 1
    wait for clock_period;
    IN_1 <= '0';
    wait for clock_period;

    IN_1 <= '1';           -- Pulse 2
    wait for clock_period;
    IN_1 <= '0';
    wait for clock_period;

    IN_1 <= '1';           -- Pulse 3
    wait for clock_period;
    IN_1 <= '0';
    wait for clock_period;

    RST_N <= '0';          -- Activate reset
    wait for clock_period;
    RST_N <= '1';          -- Deactivate reset
    wait for clock_period;

    -- Step 2: Generate 2 pulses for IN_2, 1 pulse for IN_3, and deactivate CE
    IN_2 <= '1';           -- Pulse 1 for IN_2
    wait for clock_period;
    IN_2 <= '0';
    wait for clock_period;

    IN_2 <= '1';           -- Pulse 2 for IN_2
    wait for clock_period;
    IN_2 <= '0';
    wait for clock_period;

    IN_3 <= '1';           -- Pulse for IN_3
    wait for clock_period;
    IN_3 <= '0';
    wait for clock_period;

    CE <= '0';             -- Deactivate CE
    wait for 3 * clock_period;
    CE <= '1';             -- Reactivate CE
    wait for clock_period;

    -- Step 3: Generate 1 pulse for each input and test reset again
    IN_1 <= '1';           -- Pulse for IN_1
    wait for clock_period;
    IN_1 <= '0';
    wait for clock_period;

    IN_2 <= '1';           -- Pulse for IN_2
    wait for clock_period;
    IN_2 <= '0';
    wait for clock_period;

    IN_3 <= '1';           -- Pulse for IN_3
    wait for clock_period;
    IN_3 <= '0';
    wait for clock_period;

    RST_N <= '0';          -- Activate reset again
    wait for clock_period;
    RST_N <= '1';          -- Deactivate reset
    wait for clock_period;

    -- End simulation
    wait;
  end process;

end bench;

