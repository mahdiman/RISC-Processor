LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY tsb_bit IS
	
  PORT ( E   : IN  STD_LOGIC; 
         Input  : IN  STD_LOGIC;
         Output : OUT STD_LOGIC);
END tsb_bit;

-- Architecture: tsb_arch
-- Describes the functionality of the tristate buffer

ARCHITECTURE tsb_bit_arch OF tsb_bit IS

BEGIN
  -- Tristate logic
  Output <= Input WHEN (E = '1')
  ELSE 'Z';

END tsb_bit_arch;
