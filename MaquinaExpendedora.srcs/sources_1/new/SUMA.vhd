
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SUMA is
    Port ( IN_1 : in natural range 0 to 255;
           IN_2 : in natural range 0 to 255;
           IN_3 : in natural range 0 to 255;
           CE   : in std_logic;
           TOTAL : out natural range 0 to 255);
end SUMA;

architecture Behavioral of SUMA is

begin
    process(IN_1, IN_2, IN_3, CE)
    begin
        if CE = '1' then
            TOTAL <= IN_1+IN_2+IN_3;
        else 
            TOTAL <= 0;
        end if;
    end process;

end Behavioral;
