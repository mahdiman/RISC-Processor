LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.math_real.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- ENTITY: ldstexec
-- Description: sets the signals of mem_access, write_back for the memory_access
-- stage.
-- Inputs/Outputs:
-- 1- instruction_type: code specifies which instruction in the L-Format
-- 2- rin: the destination register
-- 3- rout: the destination register 
-- 4- mem_access: memory access signal
-- 5- write_back: write_back signal
-- Note that this entity just passes the destination register saving a multiplexer in the
-- execute unit.

ENTITY ldstexec IS
	port (
	instruction_type: in std_logic_vector(3 downto 0);
	rin: in std_logic_vector(1 downto 0);
	rout: out std_logic_vector(1 downto 0);
	mem_access, write_back : out std_logic
	);
END ENTITY ldstexec;

ARCHITECTURE ldstexec_arch OF ldstexec IS

BEGIN
	-- instruction_type => 1 => LDM
	-- instruction_type => 2 => LDD
	-- instruction_type => 3 => STD
	-- instruction_type => 4 => LDI
	-- instruction_type => 5 => STI

	-- write_back signal equals 1 when instruction is load, otherwise 0.
	write_back <= '1' when 
	instruction_type = x"1" or
	instruction_type = x"2" or
	instruction_type = x"4"
	else '0';
	
	-- set memory access signal
	mem_access <= '1' when
	instruction_type = x"1" or
	instruction_type = x"2" or
	instruction_type = x"3" or
	instruction_type = x"4" or
	instruction_type = x"5"
	else '0';
	
	-- pass the rin (rb) in the memory instructions
	rout <= rin;
END;