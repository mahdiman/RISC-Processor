library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE IEEE.math_real.ALL;

-- Entity: RAM
-- Description: RAM component
-- Ports:
-- 1- clk: clock
-- 2- we: write enable
-- 3- address: address
-- 4- datain: input data
-- 5- dataout: output data
-- n: word length
-- m: memory size


ENTITY ram IS
 GENERIC ( n : integer := 8;
           m : integer := 256);
  
 PORT (clk, we : IN STD_LOGIC;
      address : IN STD_LOGIC_VECTOR(integer(ceil(log2(real(m)))) - 1 downto 0);
		  datain : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
      dataout : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));          
END ENTITY ram;



-- Architecture for entity ram

ARCHITECTURE syncrama OF ram IS  
    TYPE ram_type IS ARRAY(0 to m-1) OF STD_LOGIC_VECTOR(n-1 DOWNTO 0);
    SIGNAL ram : ram_type;
BEGIN
    PROCESS(clk) IS  
    BEGIN
        IF falling_edge(clk) THEN   
	         IF we = '1' THEN        	
            ram( to_integer( unsigned(address) ) ) <= datain;  
	         END IF;
        END IF;
    END PROCESS;

    dataout <= ram( to_integer( unsigned(address) ) );
END ARCHITECTURE syncrama;