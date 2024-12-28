
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

entity MUX_BinToBCD is
  Port (
    precio : in unsigned(7 downto 0);
    dinero : in unsigned(7 downto 0);
    cambio : in unsigned(7 downto 0);
    CE_P   : in std_logic;  --habilitación de PRECIO 
    CE_D   : in std_logic;  --habilitación de DINERO
    CE_C   : in std_logic;   --habilitación de CAMBIO
    BCD_OUT: out bcd_vector(2 downto 0)
   );
end MUX_BinToBCD;

architecture Structural of MUX_BinToBCD is
 -- Señales internas
    signal SEL : std_logic_vector(2 downto 0); -- Para habilitación del selector
    signal selector_out : unsigned(7 downto 0); -- Salida del selector
    signal unidades, decenas, centenas : bcd; -- Salidas del BinToDec
    
--declaración
component SelectorEntradas is
      Port (
        input_0 : in unsigned(7 downto 0); --primera entrada
        input_1 : in unsigned(7 downto 0); --segunda entrada
        input_2 : in unsigned(7 downto 0); --tercera entrada
        SEL     : std_logic_vector(2 downto 0); --señal de selección
        output  : out unsigned(7 downto 0) --salida seleccionada
   );
end component;

component BinToBCD is
    Port ( 
            binary_in : in unsigned(7 downto 0); --entrada binaria (0 - 255)
            unidades  : out bcd; --tipo bcd (0 a 9)
            decenas   : out bcd;
            centenas  : out bcd
    );
end component;
    
begin

    -- Concatenación de CE1, CE2, CE3 para formar SEL
    SEL <= CE_C & CE_D & CE_P; --CE( cambio  dinero  precioProducto)
    
     -- Instancia del selector de entradas
     selector: SelectorEntradas
     port map (
        input_0 => precio,  --primera entrada
        input_1 => dinero,  --segunda entrada
        input_2 => cambio,  --tercera entrada
        SEL     => SEL, --señal de selección
        output  => selector_out --salida seleccionada
   );
     
     --instancia del conversor binario a BCD
     Bin2BCD: BinToBCD
        port map(
            binary_in => selector_out,  --entrada binaria (0 - 255)
            unidades  => unidades,--tipo bcd (0 a 9)
            decenas   => decenas,
            centenas  => centenas
        );
        
     --asignar las salidas de BinToBCD a un vector
     
     BCD_OUT(0) <= unidades;
     BCD_OUT(1) <= decenas;
     BCD_OUT(2) <= centenas;
     
end Structural;
