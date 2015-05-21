Library ieee;
use ieee.std_logic_1164.all;

-- Entity: mux2
-- Description: 1x2 multiplexer
-- Ports:
-- a,b: input words
-- s0: selection
-- x: output


ENTITY mux2 IS  
  GENERIC ( n : integer := 16 );
  PORT (a, b : in STD_LOGIC_VECTOR(n-1 downto 0);
	s0 : IN STD_LOGIC ; 
	x :  OUT STD_LOGIC_VECTOR(n-1 downto 0) );    
END ENTITY mux2 ;


-- take care of the usage of when else 
ARCHITECTURE  mux2_arch OF mux2 IS
BEGIN
  x <= a WHEN s0 = '0'
  ELSE b ;
END mux2_arch;