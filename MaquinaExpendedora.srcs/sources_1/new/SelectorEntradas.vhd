----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.12.2024 01:20:54
-- Design Name: 
-- Module Name: SelectorEntradas - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SelectorEntradas is
  Port (
        input_0 : in unsigned(7 downto 0); --primera entrada
        input_1 : in unsigned(7 downto 0); --segunda entrada
        input_2 : in unsigned(7 downto 0); --tercera entrada
        SEL     : std_logic_vector(2 downto 0); --señal de selección
        output  : out unsigned(7 downto 0) --salida seleccionada
   );
end SelectorEntradas;

architecture Behavioral of SelectorEntradas is

begin
    process(SEL, input_0, input_1, input_2)
    begin
    --inicializar salida por defecto
    output <= (others=>'0');
    
    --selección de la entrada basada en SEL
    case SEL is
        when "001" =>
            output <= input_0;
        when "010" =>
            output <= input_1;
        when "100" =>
            output <= input_2;
        when others =>
            --si SEL no es válido la salida permanece a cero
            output <= (others => '0');
   end case;
   end process;
end Behavioral;
