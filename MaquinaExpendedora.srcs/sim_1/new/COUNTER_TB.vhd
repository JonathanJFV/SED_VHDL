library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity COUNTER_tb is
end COUNTER_tb;

architecture bench of COUNTER_tb is

  -- Componente del contador
  component COUNTER   
    generic(
        NBITS: natural := 8
    );
    Port ( 
      RST_N : in STD_LOGIC;
      CLK   : in STD_LOGIC;
      CE    : in STD_LOGIC;
      Q     : out natural range 0 to 255
    );
  end component;

  -- Señales para el testbench
  signal RST_N : STD_LOGIC := '1';  -- Inicializa el reset activo
  signal CLK   : STD_LOGIC := '0';  -- Reloj
  signal CE    : STD_LOGIC := '0';  -- Clock Enable (desactivado inicialmente)
  signal Q     : natural range 0 to 255;  -- Señal de salida del contador

  constant clock_period: time := 10 ns;  -- Período del reloj
  signal stop_the_clock: boolean := false;

begin

  -- Instanciación de la unidad bajo prueba (UUT)
  uut: COUNTER generic map ( NBITS => 8 )  -- Ajuste según el ancho de bits del contador
    port map (
      RST_N => RST_N,
      CLK   => CLK,
      CE    => CE,
      Q     => Q
    );

  -- Proceso de estímulos
  stimulus: process
  begin
    -- Inicialización del proceso de estímulos
    -- Establecemos el reset en bajo durante un corto período para inicializar el contador
    RST_N <= '0';  -- Activamos el reset
    wait for 20 ns;  -- Esperamos a que el reset se propague
    RST_N <= '1';  -- Desactivamos el reset

    -- Iniciamos la simulación con CE activado
    CE <= '1';  -- Habilitamos el contador

    -- Esperamos un par de ciclos de reloj antes de comenzar a verificar
    wait for clock_period * 2;

    -- Comenzamos a verificar la cuenta
    for i in 0 to 10 loop
      -- Verificamos el valor de Q después de cada flanco de reloj
      wait until CLK = '1';  -- Esperamos al flanco de subida del reloj
      wait for clock_period / 2;  -- Esperamos la mitad del período del reloj
      assert Q = i report "Contador no funciona correctamente en la cuenta " & integer'image(i)
        severity failure;
    end loop;

    -- Detener la simulación después de verificar hasta la cuenta 10
    stop_the_clock <= true;
    wait;
  end process;

  -- Proceso del reloj
  clocking: process
  begin
    while not stop_the_clock loop
      CLK <= '0', '1' after clock_period / 2;  -- Generar el flanco de subida y bajada
      wait for clock_period;  -- Esperar al siguiente ciclo de reloj
    end loop;
    wait;
  end process;

end bench;


