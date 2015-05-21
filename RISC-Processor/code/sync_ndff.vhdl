LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- ENTITY ndff
-- Describes a n-bits D-FlipFlop
-- Clk: Clock
-- Rst: Reset
-- E: Enable
-- d: Input stream
-- output: Output stream

ENTITY ndff_sync IS
  GENERIC ( n : integer := 8);
  PORT( Clk,Rst,E : in STD_LOGIC;
        d : IN STD_LOGIC_VECTOR(n-1 dOWNTO 0);
        output : OUT STD_LOGIC_VECTOR(n-1 dOWNTO 0));
END ndff_sync;

-- Architecture ndff_arch
-- describes the D-FilpFlop Functionality

ARCHITECTURE ndff_sync_arch OF ndff_sync IS

BEGIN
  process(Clk,Rst, E)
  begin
  if rising_edge( Clk ) then
    if(Rst = '1') then
	   output <= (others => '0');
    elsif E = '1' then
	   output <= d;
    end if;
  end if;
  end process;
END ndff_sync_arch;