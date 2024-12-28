--
--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 
--
--   To use any of the example code shown below, uncomment the lines and modify as necessary
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package common is

  subtype bcd is unsigned(3 downto 0);
  type bcd_vector is array(integer range <>) of bcd;

end common;

package body common is
end common;

