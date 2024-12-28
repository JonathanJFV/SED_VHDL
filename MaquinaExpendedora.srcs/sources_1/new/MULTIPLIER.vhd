----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.12.2024 17:27:58
-- Design Name: 
-- Module Name: MULTIPLIER - Behavioral
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

entity MULTIPLIER is

    Port ( FACTOR_1 : in natural range 0 to 255; --recibe la salida Q del contador
           FACTOR_2 : in natural range 0 to 255;                      --valor natural de la moneda
           RESULT : out natural range 0 to 255                        --resultado
         );
end MULTIPLIER;

architecture Behavioral of MULTIPLIER is
    
begin
    process(FACTOR_1) 
        variable product : natural;     --variable para almacenar el producto
    begin
    
        product := FACTOR_1 * FACTOR_2;
        RESULT <= product;
        
    end process;
end Behavioral;
