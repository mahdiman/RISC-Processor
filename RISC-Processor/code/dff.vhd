LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- Entity dff
-- Represents a single bit D-FlipFlop
-- d: input value to be stored
-- clk: clock
-- rst: reset
-- E: enable
-- output: output bit

ENTITY dff_bit IS

  PORT( d,clk,rst,E : IN STD_LOGIC;
  output : OUT STD_LOGIC);

END dff_bit;

-- Architecture: dff_arch
-- Describes the functionality of the D-FlipFlop

ARCHITECTURE dff_arch OF dff_bit IS
BEGIN

PROCESS(clk, E, rst)
BEGIN
  if( rst = '1' ) then
    output <= '0'; 
  elsif(rising_edge(clk)) then
    if(E = '1') then
      output <= d;
    end if;
  end if;
END PROCESS;

END dff_arch;