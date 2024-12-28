

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library work;
use work.common.all;

entity BinToBCD is
    Port ( 
            binary_in : in unsigned(7 downto 0); --entrada binaria (0 - 255)
            unidades  : out bcd; --tipo bcd (0 a 9)
            decenas   : out bcd;
            centenas  : out bcd
    );
end BinToBCD;

architecture Behavioral of BinToBCD is
begin
 process(binary_in)
        variable temp : integer;
        variable u, d, c : integer;
    begin
        -- Convierte el vector unsigned a entero
        temp := to_integer(binary_in);

        -- Obtener centenas, decenas y unidades
        c := temp / 100; -- Centenas
        temp := temp mod 100;

        d := temp / 10;  -- Decenas
        u := temp mod 10; -- Unidades

        -- Asignar las salidas utilizando el tipo bcd
        centenas <= to_unsigned(c, 4);
        decenas <= to_unsigned(d, 4);
        unidades <= to_unsigned(u, 4);
    end process;

end Behavioral;
