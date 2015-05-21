LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Entity tsb
-- Represents a tristate buffer with n-bits input & output.
-- E: enable bit
-- Input: Input stream
-- Output: Output stream

ENTITY tsb IS
	GENERIC ( n : integer := 8);
	
  PORT ( E   : IN  STD_LOGIC; 
         Input  : IN  STD_LOGIC_VECTOR (n-1 DOWNTO 0);
         Output : OUT STD_LOGIC_VECTOR (n-1 DOWNTO 0));
END tsb;

-- Architecture: tsb_arch
-- Describes the functionality of the tristate buffer

ARCHITECTURE tsb_arch OF tsb IS

BEGIN
  -- Tristate logic
  Output <= Input WHEN (E = '1')
  ELSE (OTHERS =>'Z');

END tsb_arch;
