LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.math_real.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY nDecoder IS
  
  GENERIC ( n : integer := 3);
  PORT(E : IN std_logic;
       S : IN STD_LOGIC_VECTOR( n-1 DOWNTO 0);
       output : OUT std_logic_vector((2 ** n) - 1 DOWNTO 0));

END nDecoder;

ARCHITECTURE nDecoder_arch OF nDecoder IS
BEGIN


PROCESS(E,S)
  BEGIN
    FOR i IN 0 TO (2 ** n) - 1 LOOP
      IF E = '1' AND to_integer(unsigned(S)) = i THEN
        output(i) <= '1';
      ELSE
        output(i) <= '0';
      END IF;
    END LOOP;
END PROCESS;

END nDecoder_arch;
