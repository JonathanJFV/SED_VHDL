----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.12.2024 21:57:37
-- Design Name: 
-- Module Name: COUNTR_TB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity COUNTR_TB is
--  Port ( );
end COUNTR_TB;

architecture bench of COUNTR_TB is

  -- Declaración del componente a probar
  component COUNTER   
      generic(
          NBITS: natural := 8
      );
      Port ( RST_N : in STD_LOGIC;
             CLK : in STD_LOGIC;
             CE  : in STD_LOGIC;
             Q : out natural range 0 to 255
            );
  end component;

  -- Declaración de señales para conectar al componente
  signal RST_N: STD_LOGIC;
  signal CLK: STD_LOGIC;
  signal CE: STD_LOGIC;
  signal Q: natural range 0 to 255;

  -- Parámetros de simulación
  constant clock_period: time := 10 ns; -- Período del reloj
  signal stop_the_clock: boolean := false; -- Señal para detener el reloj

begin

  -- Instanciación del contador
  uut: COUNTER 
      generic map ( NBITS => 8 ) -- Ancho del contador
      port map ( RST_N => RST_N,
                 CLK   => CLK,
                 CE    => CE,
                 Q     => Q );

  -- Generación de estímulos
  stimulus: process
  begin
    -- Inicialización: Reinicio del contador
    RST_N <= '0';
    CE <= '0';
    wait for 20 ns; -- Espera durante el reinicio

    -- Liberar el reinicio
    RST_N <= '1';
    wait for 10 ns;

    -- Habilitar el contador y permitir el conteo
    CE <= '1';
    wait for 100 ns; -- Dejarlo contando

    -- Deshabilitar el contador para observar comportamiento
    CE <= '0';
    wait for 40 ns;

    -- Volver a habilitar y observar el conteo hasta 10
    CE <= '1';
    wait for 100 ns;

    -- Finalizar la simulación
    stop_the_clock <= true;
    wait;
  end process;

  -- Generación del reloj
  clocking: process
  begin
    while not stop_the_clock loop
      CLK <= '0', '1' after clock_period / 2; -- Generar flancos
      wait for clock_period;
    end loop;
    wait;
  end process;

end;