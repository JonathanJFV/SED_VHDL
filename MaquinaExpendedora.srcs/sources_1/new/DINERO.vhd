
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity DINERO is
    Port ( IN_1 : in STD_LOGIC;
           IN_2 : in STD_LOGIC;
           IN_3 : in STD_LOGIC;
           CE   : in STD_LOGIC;
           RST_N : in STD_LOGIC;
           CLK : in STD_LOGIC;
           DINERO : out unsigned (7 downto 0));
end entity;

architecture Structural of DINERO is
    --señales internas
signal Q1, Q2, Q3 : natural range 0 to 255; --señales de salida de los contadores
signal R1, R2, R3 : natural range 0 to 255; --señales de salida de las multiplicaciones
signal TOTAL_sum  : natural range 0 to 255;  

--instancias de los contadores
component COUNTER is
    port(   CE : in std_logic;
            RST_N : in std_logic;
            CLK : in std_logic;
            Q : out natural range 0 to 255
    );
end component;

--instancias de los multiplicadores
component MULTIPLIER is
    port(FACTOR_1 : in natural range 0 to 255;
         FACTOR_2 : in natural range 0 to 255;
         RESULT   : out natural range 0 to 255
    );
end component;

--instancia de SUMA
component SUMA is 
        Port ( IN_1 : in natural range 0 to 255;
           IN_2 : in natural range 0 to 255;
           IN_3 : in natural range 0 to 255;
           CE   : in std_logic;
           TOTAL : out natural range 0 to 255
           );
end component;

begin
--instancias de los contadores
COUNTER1: COUNTER
    port map ( CE => IN_1, 
               RST_N => CE, --verifiar: cuando CE es 0, el contador se pone a cero 
               CLK => CLK, 
               Q => Q1);

COUNTER2: COUNTER
    port map ( CE => IN_2, 
               RST_N => CE, 
               CLK => CLK, 
               Q => Q2);
COUNTER3: COUNTER
    port map ( CE => IN_3, 
               RST_N => CE, 
               CLK => CLK, 
               Q => Q3);

-- Instancias de los multiplicadores (Valores de moneda 10, 20, 50, 100)
 MULT_10: MULTIPLIER
    port map ( FACTOR_1 => Q1, 
               FACTOR_2 => 10, -- Valor de moneda para el primer multiplicador
               RESULT => R1);
 MULT_20: MULTIPLIER
    port map ( FACTOR_1 => Q2, 
               FACTOR_2 => 20, -- Valor de moneda para el segundo multiplicador
               RESULT => R2);
               
 MULT_50: MULTIPLIER
    port map ( FACTOR_1 => Q3, 
               FACTOR_2 => 50, -- Valor de moneda para el tercer multiplicador
               RESULT => R3 );

--istancia de SUMA
SUMADOR: SUMA
    port map ( IN_1 => R1,
               IN_2 => R2,
               IN_3 => R3,
               CE => RST_N,
               TOTAL => TOTAL_sum );
              
    --hace una conversión a unsigned de la salida de suma que es de tipo natural              
 DINERO <= to_unsigned(TOTAL_sum, DINERO'length);  
 
 
end Structural;
