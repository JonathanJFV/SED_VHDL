
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

library work;
use work.common.all;

entity MUX_BinToBCD_TB is
end;

architecture bench of MUX_BinToBCD_TB is

  component MUX_BinToBCD
    Port (
      precio : in unsigned(7 downto 0);
      dinero : in unsigned(7 downto 0);
      cambio : in unsigned(7 downto 0);
      CE_P   : in std_logic;
      CE_D   : in std_logic;
      CE_C   : in std_logic;
      BCD_OUT: out bcd_vector(2 downto 0)
     );
  end component;

  signal precio: unsigned(7 downto 0);
  signal dinero: unsigned(7 downto 0);
  signal cambio: unsigned(7 downto 0);
  signal CE_P: std_logic;
  signal CE_D: std_logic;
  signal CE_C: std_logic;
  signal BCD_OUT: bcd_vector(2 downto 0) ;

begin

  uut: MUX_BinToBCD port map ( precio  => precio,
                               dinero  => dinero,
                               cambio  => cambio,
                               CE_P    => CE_P,
                               CE_D    => CE_D,
                               CE_C    => CE_C,
                               BCD_OUT => BCD_OUT );

  stimulus: process
    -- Variables locales para calcular el BCD esperado
    variable precio_bcd: bcd_vector(2 downto 0);
    variable dinero_bcd: bcd_vector(2 downto 0);
    variable cambio_bcd: bcd_vector(2 downto 0);
  begin
    -- Inicialización de señales
    precio <= to_unsigned(160, 8);  -- 160 en binario
    dinero <= to_unsigned(225, 8);  -- 225 en binario
    cambio <= to_unsigned(45, 8);   -- 45 en binario
    CE_P <= '0';
    CE_D <= '0';
    CE_C <= '0';
    wait for 100 ns; -- Tiempo de estabilización inicial
    
    -- Cálculo del BCD esperado
    precio_bcd(2) := "0001"; -- Centenas de 160
    precio_bcd(1) := "0110"; -- Decenas de 160
    precio_bcd(0) := "0000"; -- Unidades de 160

    dinero_bcd(2) := "0010"; -- Centenas de 225
    dinero_bcd(1) := "0010"; -- Decenas de 225
    dinero_bcd(0) := "0101"; -- Unidades de 225

    cambio_bcd(2) := "0000"; -- Centenas de 45
    cambio_bcd(1) := "0100"; -- Decenas de 45
    cambio_bcd(0) := "0101"; -- Unidades de 45

    -- Activación de CE_P y comprobación de BCD_OUT
    CE_P <= '1';
    wait for 200 ns; -- Mantener CE_P activo durante 2 ciclos
    wait for 100 ns; -- Tiempo adicional para que las salidas se estabilicen
    CE_P <= '0';
    assert BCD_OUT(2) = precio_bcd(2) report "Error en BCD_OUT(2) para CE_P" severity failure;
    assert BCD_OUT(1) = precio_bcd(1) report "Error en BCD_OUT(1) para CE_P" severity failure;
    assert BCD_OUT(0) = precio_bcd(0) report "Error en BCD_OUT(0) para CE_P" severity failure;
    wait for 100 ns;

    -- Activación de CE_D y comprobación de BCD_OUT
    CE_D <= '1';
    wait for 200 ns; -- Mantener CE_D activo durante 2 ciclos
    wait for 100 ns; -- Tiempo adicional para que las salidas se estabilicen
    CE_D <= '0';
    assert BCD_OUT(2) = dinero_bcd(2) report "Error en BCD_OUT(2) para CE_D" severity failure;
    assert BCD_OUT(1) = dinero_bcd(1) report "Error en BCD_OUT(1) para CE_D" severity failure;
    assert BCD_OUT(0) = dinero_bcd(0) report "Error en BCD_OUT(0) para CE_D" severity failure;
    wait for 100 ns;

    -- Activación de CE_C y comprobación de BCD_OUT
    CE_C <= '1';
    wait for 200 ns; -- Mantener CE_C activo durante 2 ciclos
    wait for 100 ns; -- Tiempo adicional para que las salidas se estabilicen
    CE_C <= '0';
    assert BCD_OUT(2) = cambio_bcd(2) report "Error en BCD_OUT(2) para CE_C" severity failure;
    assert BCD_OUT(1) = cambio_bcd(1) report "Error en BCD_OUT(1) para CE_C" severity failure;
    assert BCD_OUT(0) = cambio_bcd(0) report "Error en BCD_OUT(0) para CE_C" severity failure;
    wait for 100 ns;

    -- Finalización de la simulación
    wait;
  end process;


end;
