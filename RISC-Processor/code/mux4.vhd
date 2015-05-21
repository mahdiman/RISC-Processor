Library ieee;
USE ieee.std_logic_1164.ALL;

ENTITY mux4 IS 
  GENERIC ( n : integer := 16 );
	PORT ( a,b,c,d : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	       s0,s1 : IN STD_LOGIC ;
			   y	: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
			
END ENTITY mux4;


-- circuit flow

ARCHITECTURE mux4_arch of mux4 is
begin
     y <=   a WHEN s0 = '0' and s1 ='0'
       ELSE b WHEN s0 = '0' and s1 ='1'
       ELSE c WHEN s0 = '1' and s1 ='0'
	     ELSE d;
end mux4_arch;

