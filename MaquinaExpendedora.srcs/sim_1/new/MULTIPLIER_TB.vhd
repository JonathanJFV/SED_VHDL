

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MULTIPLIER_TB is
--  Port ( );
end MULTIPLIER_TB;

architecture Behavioral of MULTIPLIER_TB is
    -- Señales internas para conectar con el DUT
    signal FACTOR_1 : natural range 0 to 255;
    signal FACTOR_2 : natural := 10; -- Constante para el estímulo
    signal RESULT   : natural;

    -- Tiempo de simulación entre cambios
    constant CLK_PERIOD : time := 10 ns;

begin
    -- Instancia del DUT (Device Under Test)
    UUT: entity work.MULTIPLIER
        port map (
            FACTOR_1 => FACTOR_1,
            FACTOR_2 => FACTOR_2,
            RESULT   => RESULT
        );

    -- Proceso para generar estímulos
    stimulus_process: process
    begin
        for i in 0 to 10 loop
            -- Asignar valores al estímulo
            FACTOR_1 <= i; 
            wait for CLK_PERIOD; -- Esperar un ciclo
        end loop;

        -- Finalizar simulación
        wait;
    end process;
end Behavioral;