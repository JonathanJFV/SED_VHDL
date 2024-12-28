----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.12.2024 19:13:57
-- Design Name: 
-- Module Name: SUMA_TB - Behavioral
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

entity SUMA_TB is
--  Port ( );
end SUMA_TB;

architecture bench of SUMA_TB is

  -- Componente SUMA
  component SUMA
      Port ( IN_1 : in natural range 0 to 255;
             IN_2 : in natural range 0 to 255;
             IN_3 : in natural range 0 to 255;
             CE : in STD_LOGIC;
             TOTAL : out natural range 0 to 255);
  end component;

  -- Señales del testbench
  signal IN_1: natural range 0 to 255;
  signal IN_2: natural range 0 to 255;
  signal IN_3: natural range 0 to 255;
  signal CE: STD_LOGIC := '0'; -- Inicializamos CE a '0'
  signal TOTAL: natural range 0 to 255;

begin

  -- Instancia del DUT (Device Under Test)
  uut: SUMA port map (
                       IN_1  => IN_1,
                       IN_2  => IN_2,
                       IN_3  => IN_3,
                       CE    => CE,
                       TOTAL => TOTAL );

  -- Proceso de estímulos
  stimulus: process
  begin
    -- Inicialización
    IN_1 <= 10; IN_2 <= 20; IN_3 <= 30; 
    CE <= '1'; -- CE a '1' para realizar la suma
    wait for 10 ns; -- Espera un ciclo

    -- Primer cambio de entradas
    IN_1 <= 20; IN_2 <= 30; IN_3 <= 40; 
    wait for 10 ns; -- Espera un ciclo

    -- Segundo cambio de entradas
    IN_1 <= 30; IN_2 <= 40; IN_3 <= 50; 
    wait for 10 ns; -- Espera un ciclo

    -- Tercer cambio de entradas
    IN_1 <= 40; IN_2 <= 50; IN_3 <= 60; 
    wait for 10 ns; -- Espera un ciclo

    -- Ahora desactivamos CE (ponemos a '0') para verificar que TOTAL se limpia
    CE <= '0'; -- CE a '0', TOTAL debería limpiarse
    wait for 10 ns; -- Espera un ciclo

    -- Reanudamos con CE en '1'
    CE <= '1'; 
    IN_1 <= 50; IN_2 <= 20; IN_3 <= 10;
    wait for 10 ns; -- Espera un ciclo

    -- Terminamos la simulación
    wait;
  end process;

end bench;