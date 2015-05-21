LIBRARY ieee;
use ieee.std_logic_1164.all;
use IEEE.math_real.all;
use IEEE.NUMERIC_STD.all;


-- input:
-- r0: register 0
-- r1: register 1
-- r2: register 2
-- r3: register 3
-- ra: first operand (aka brx)
-- rb: second operand
-- value: value computed in decode stage and passed down to branch component in case of RET and RTI
-- fetch: value computed for next PC value by fetch register
-- flags: flags register
-- mode: mode computed in decode stage, ranging from 0000 for JZ to 1000 for RTI respectively as in the project document

-- output:
-- PC: value computed for PC


entity branch_component is 
	port(
		pc_branch_value, ra: in std_logic_vector (7 downto 0);
 		mode, flags: in std_logic_vector(3 downto 0);
		pc_pre : in std_logic_vector(7 downto 0);		
		pc_next : out std_logic_vector(7 downto 0);
		flush: out std_logic
	);
end branch_component;

architecture branch_component_arch of branch_component is
	-- Signals:
	-- N: high when N flag jump conditions are satisfied
	-- Z: high when Z flag jump conditions are satisfied
	-- C: high when C flag jump conditions are satisfied
	-- V: high when V flag jump conditions are satisfied
	-- Loop_condition: high when Loop_condition jump conditions are satisfied
	-- Jmp_condition: high when Jmp_condition jump conditions are satisfied
	-- Call_condition: high when Call_condition jump conditions are satisfied
	-- Ret_condition: high when Ret_condition jump conditions are satisfied
	-- Rti_condition: high when Rti_condition jump conditions are satisfied
	-- R_rb: high when the conditions for PC to take the value of R[rb] are satisfied

	signal N, Z, V, C : std_logic;
begin
	
	Z <= flags(0);
	N <= flags(1);
	C <= flags(2);
	V <= flags(3);

	pc_next <= pc_branch_value
		when ( mode = x"1" and Z = '1' )
		or   ( mode = x"2" and N = '1' )
		or   ( mode = x"3" and C = '1' )
		or   ( mode = x"4" and v = '1' )
		or   ( mode = x"5" and ra /= "00000001" )
		or   ( mode = x"6" )
		or   ( mode = x"7" )
		or   ( mode = x"8" )
		or   ( mode = x"9" )
	else std_logic_vector( unsigned( pc_pre ) + 1 ); 

	flush <= '1' 
		when ( mode = x"1" and Z = '1' )
		or   ( mode = x"2" and N = '1' )
		or   ( mode = x"3" and C = '1' )
		or   ( mode = x"4" and v = '1' )
		or   ( mode = x"5" and ra /= "00000001" )
		or   ( mode = x"6" )
		or   ( mode = x"7" )
		or   ( mode = x"8" )
		or   ( mode = x"9" )
	else '0';

end architecture;