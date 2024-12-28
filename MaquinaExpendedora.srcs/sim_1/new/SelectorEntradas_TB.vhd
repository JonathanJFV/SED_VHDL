
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SelectorEntradas_TB is
--  Port ( );
end SelectorEntradas_TB;

architecture bench of SelectorEntradas_TB is

    component SelectorEntradas
        port (
            input_0 : in unsigned (7 downto 0);
            input_1 : in unsigned (7 downto 0);
            input_2 : in unsigned (7 downto 0);
            SEL     : in std_logic_vector (2 downto 0);
            output  : out unsigned (7 downto 0)
        );
    end component;

    signal input_0 : unsigned (7 downto 0);
    signal input_1 : unsigned (7 downto 0);
    signal input_2 : unsigned (7 downto 0);
    signal SEL     : std_logic_vector (2 downto 0);
    signal output  : unsigned (7 downto 0);

begin

    -- Instancia del DUT
    dut : SelectorEntradas
        port map (
            input_0 => input_0,
            input_1 => input_1,
            input_2 => input_2,
            SEL     => SEL,
            output  => output
        );

    -- Proceso de estímulos
    stimuli : process
    begin
        -- Estímulo 1: Inicialización
        input_0 <= to_unsigned(42, 8);
        input_1 <= to_unsigned(84, 8);
        input_2 <= to_unsigned(126, 8);
        SEL <= "000"; -- Sin selección, salida esperada = 0
        wait for 100 ns;

        -- Estímulo 2: SEL = "001", debe pasar input_0
        SEL <= "001";
        wait for 100 ns;

        -- Estímulo 3: SEL = "010", debe pasar input_1
        SEL <= "010";
        wait for 100 ns;

        -- Estímulo 4: SEL = "100", debe pasar input_2
        SEL <= "100";
        wait for 100 ns;

        -- Estímulo 5: SEL inválido, salida esperada = 0
        SEL <= "011";
        wait for 100 ns;
        
        -- Estímulo 1: Inicialización
        input_0 <= to_unsigned(100, 8);
        input_1 <= to_unsigned(5, 8);
        input_2 <= to_unsigned(99, 8);
        SEL <= "000"; -- Sin selección, salida esperada = 0
        wait for 100 ns;

        -- Estímulo 2: SEL = "001", debe pasar input_0
        SEL <= "001";
        wait for 100 ns;

        -- Estímulo 3: SEL = "010", debe pasar input_1
        SEL <= "010";
        wait for 100 ns;

        -- Estímulo 4: SEL = "100", debe pasar input_2
        SEL <= "100";
        wait for 100 ns;

        -- Estímulo 5: SEL inválido, salida esperada = 0
        SEL <= "011";
        wait for 100 ns;

        -- Finalizar simulación
        wait;
    end process;
end bench;
