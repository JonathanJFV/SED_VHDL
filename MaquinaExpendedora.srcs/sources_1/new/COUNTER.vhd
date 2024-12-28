
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity COUNTER is   
    generic(
        NBITS: natural := 8 --ancho del contador
    );
    Port ( RST_N : in STD_LOGIC;    --reset 
           CLK : in STD_LOGIC;      --reloj
           CE  : in STD_LOGIC;
           Q : out natural range 0 to 255 --salida del contador 0-255
          );
end COUNTER;

architecture Behavioral of COUNTER is
    signal q_i: unsigned(7 downto 0);
begin

    process(RST_N, CLK)
    begin
        if RST_N = '0' then 
            q_i <= (others => '0');
        elsif rising_edge(CLK) then
            if CE = '1' then
                q_i <= q_i + 1;
            end if;
        end if;
   end process;     
        
   Q <= TO_INTEGER(q_i);
   
end Behavioral;
