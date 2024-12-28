
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

entity BinToBCD_TB is
--  Port ( );
end BinToBCD_TB;

architecture Behavioral of BinToBCD_TB is

  component BinToBCD
      Port ( 
              binary_in : in unsigned(7 downto 0);
              unidades  : out bcd;
              decenas   : out bcd;
              centenas  : out bcd
      );
  end component;

  signal binary_in: unsigned(7 downto 0);
  signal unidades: bcd;
  signal decenas: bcd;
  signal centenas: bcd;

begin

  uut: BinToBCD 
    port map ( 
        binary_in => binary_in,
        unidades  => unidades,
        decenas   => decenas,
        centenas  => centenas 
    );

  stimulus: process
  begin
    -- Inicialización
    binary_in <= to_unsigned(0, 8);
    wait for 50 ns;

    -- Caso 1: Valor mínimo
    binary_in <= to_unsigned(0, 8); -- Entrada: 0, Salida esperada: 0 unidades, 0 decenas, 0 centenas
    wait for 50 ns;

    -- Caso 2: Número bajo
    binary_in <= to_unsigned(7, 8); -- Entrada: 7, Salida esperada: 7 unidades, 0 decenas, 0 centenas
    wait for 50 ns;

    -- Caso 3: Número con decenas
    binary_in <= to_unsigned(45, 8); -- Entrada: 45, Salida esperada: 5 unidades, 4 decenas, 0 centenas
    wait for 50 ns;

    -- Caso 4: Número con centenas
    binary_in <= to_unsigned(123, 8); -- Entrada: 123, Salida esperada: 3 unidades, 2 decenas, 1 centenas
    wait for 50 ns;

    -- Caso 5: Valor máximo
    binary_in <= to_unsigned(255, 8); -- Entrada: 255, Salida esperada: 5 unidades, 5 decenas, 2 centenas
    wait for 50 ns;

    -- Caso 6: Número intermedio
    binary_in <= to_unsigned(98, 8); -- Entrada: 98, Salida esperada: 8 unidades, 9 decenas, 0 centenas
    wait for 50 ns;

    -- Finalizar simulación
    wait;
  end process;

end Behavioral;
