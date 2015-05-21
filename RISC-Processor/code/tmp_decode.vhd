LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.math_real.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY decode IS 
	PORT(
 		instruction : in std_logic_vector(7 downto 0);
		r0, r1, r2, r3: in std_logic_vector(7 downto 0);
		mode: out std_logic_vector(5 downto 0);
		op1, op2 : out std_logic_vector(7 downto 0);
		ra, rb : out std_logic_vector(1 downto 0);
		f1, f2, get_from_fetch : out std_logic;
		cin, mem_access, write_back, flag_change, sel_dst : out std_logic
	);
END decode;

architecture decode_arch OF decode IS
	signal ra_sig, rb_sig : std_logic_vector(1 downto 0);
	

begin
	-- instruction-code => 12 => LDM
	-- instruction-code => 12 => LDD
	-- instruction-code => 12 => STD
	-- instruction-code => 13 => LDI
	-- instruction-code => 14 => STI

	-- memory access modes
	mode <= "010001" when instruction(7 downto 4) = x"c" and instruction(3 downto 2) = "00"
	else	"010010" when instruction(7 downto 4) = x"c" and instruction(3 downto 2) = "01"
	else	"010011" when instruction(7 downto 4) = x"c" and instruction(3 downto 2) = "10"
	else	"010100" when instruction(7 downto 4) = x"d"
	else	"010101" when instruction(7 downto 4) = x"e"
	
	-- alu modes
	else	"000000" when instruction(7 downto 4) = x"0"
	else 	"000000" when instruction(7 downto 4) = x"1"
	else 	"000001" when instruction(7 downto 4) = x"2"
	else 	"000010" when instruction(7 downto 4) = x"3"
	else 	"000100" when instruction(7 downto 4) = x"4"
	else 	"000101" when instruction(7 downto 4) = x"5"
	else 	"001110" when instruction(7 downto 4) = x"6" and instruction(3 downto 2) = "00"
	else 	"001010" when instruction(7 downto 4) = x"6" and instruction(3 downto 2) = "01"
	else 	"000101" when instruction(7 downto 4) = x"6" and instruction(3 downto 2) = "10"
	else 	"000100" when instruction(7 downto 4) = x"6" and instruction(3 downto 2) = "11"
	else 	"000000" when instruction(7 downto 4) = x"7" and instruction(3 downto 2) = "00"
	else 	"000000" when instruction(7 downto 4) = x"7" and instruction(3 downto 2) = "01"
	else 	"000000" when instruction(7 downto 4) = x"7" and instruction(3 downto 2) = "10"
	else 	"000000" when instruction(7 downto 4) = x"7" and instruction(3 downto 2) = "11"
	else 	"000111" when instruction(7 downto 4) = x"8" and instruction(3 downto 2) = "00"
	else 	"000000" when instruction(7 downto 4) = x"8" and instruction(3 downto 2) = "01"
	else 	"000000" when instruction(7 downto 4) = x"8" and instruction(3 downto 2) = "10"
	else 	"000011" when instruction(7 downto 4) = x"8" and instruction(3 downto 2) = "11";
	
	-- get first operand index
	ra_sig <= instruction(1 downto 0) when instruction(7 downto 4) = x"c" 
	or	instruction(7 downto 4) = x"e"
	or 	instruction(7 downto 4) = x"d"
	or	instruction(7 downto 4) = x"1"
	or	( instruction(7 downto 4) = x"6" and instruction(3 downto 2) = "00" )
	or	( instruction(7 downto 4) = x"6" and instruction(3 downto 2) = "01" )
	or	instruction(7 downto 4) = x"8"
	or	( instruction(7 downto 4) = x"7" and instruction(3 downto 2) = "00" ) 
	or	( instruction(7 downto 4) = x"7" and instruction(3 downto 2) = "10" )
	or	( instruction(7 downto 4) = x"7" and instruction(3 downto 2) = "11" )


	else instruction(3 downto 2) when instruction(7 downto 4) = x"0"
	or	 instruction(7 downto 4) = x"2"
	or	 instruction(7 downto 4) = x"3"
	or	 instruction(7 downto 4) = x"4"
	or	 instruction(7 downto 4) = x"5"

		
	else "11" when ( instruction(7 downto 4) = x"7" and instruction(3 downto 2) = "01" ) 
	or	 ( instruction(7 downto 4) = x"6" and instruction(3 downto 2) = "10" )
	or	 ( instruction(7 downto 4) = x"6" and instruction(3 downto 2) = "11" )

	else "00";
	-- done getting first operand index

	-- get second operand index
	rb_sig <= instruction(3 downto 2) when instruction(7 downto 4) = x"c" 
	or	instruction(7 downto 4) = x"e"
	or	instruction(7 downto 4) = x"d"
	or	instruction(7 downto 4) = x"1"
	
	else 	instruction(1 downto 0) when instruction(7 downto 4) = x"0"
	or	instruction(7 downto 4) = x"2"
	or	instruction(7 downto 4) = x"3"
	or	instruction(7 downto 4) = x"4"
	or	instruction(7 downto 4) = x"5"
	or	( instruction(7 downto 4) = x"6" and instruction(3 downto 2) = "00" )
	or	( instruction(7 downto 4) = x"6" and instruction(3 downto 2) = "01" )
	or	( instruction(7 downto 4) = x"7" and instruction(3 downto 2) = "01" )
	or	( instruction(7 downto 4) = x"7" and instruction(3 downto 2) = "10" )
	or	( instruction(7 downto 4) = x"7" and instruction(3 downto 2) = "11" )
	or	instruction(7 downto 4) = x"8"

	else "11" 
	when ( instruction(7 downto 4) = x"7" and instruction(3 downto 2) = "00" )
	or	 ( instruction(7 downto 4) = x"6" and instruction(3 downto 2) = "10" )
	or	 ( instruction(7 downto 4) = x"6" and instruction(3 downto 2) = "11" )

	else "00";
	-- done getting second operand index
	

	-- enable forwarding for register#1
	f1 <= '0' when 
	(instruction(7 downto 4) = x"c" and (instruction(3 downto 2) = "00" or instruction(3 downto 2) = "01"))
	or instruction(7 downto 4) = x"d"
	else '1' ;
	-- done enabling forwarding for register#1


	-- enable forwarding for register#2
	f2 <= '0' when instruction(7 downto 4) = x"c"
	else '1' when instruction(7 downto 4) = x"d" or
	instruction(7 downto 4) = x"e";

	-- need another fetch to get data/address.
	get_from_fetch <= '1' when instruction(7 downto 4) = x"c"
	else '0';

	-- set memory access signal (enable/disable)
	mem_access <= '1' when 
	(instruction(7 downto 4) = x"c" and ( instruction(3 downto 2) = "01" or  instruction(3 downto 2) = "10" ))
	or	instruction(7 downto 4) = x"d" or instruction(7 downto 4) = x"e"
	or	( instruction(7 downto 4) = x"7" and instruction(3 downto 2) = "00" )
	or	( instruction(7 downto 4) = x"7" and instruction(3 downto 2) = "01" )
	else '0';
	
	-- set write_back signal
	write_back <= '0' when (instruction(7 downto 4) = x"c" and instruction(3 downto 2) = "10")
	or	instruction(7 downto 4) = x"e"
	or	instruction(7 downto 4) = x"0"
	or	 ( instruction(7 downto 4) = x"6" and instruction(3 downto 2) = "10" )
	or	 ( instruction(7 downto 4) = x"6" and instruction(3 downto 2) = "11" )
	or	 ( instruction(7 downto 4) = x"7" and instruction(3 downto 2) = "00" )
	or	 ( instruction(7 downto 4) = x"7" and instruction(3 downto 2) = "10" )
	else '1';
	
	-- select the destination register
	sel_dst <= '1' when instruction(7 downto 4) = x"c"
	or instruction(7 downto 4) = x"d"
	or instruction(7 downto 4) = x"e"
	or instruction(7 downto 4) = x"1"
	or ( instruction(7 downto 4) = x"7" and instruction(3 downto 2) = "01" )
	or ( instruction(7 downto 4) = x"7" and instruction(3 downto 2) = "11" )
	else '0';
	
	-- set the cin signal (1/0)
	cin <= '1' when instruction(7 downto 4) = x"3"
	or ( instruction(7 downto 4) = x"7" and instruction(3 downto 2) = "01" )
	or ( instruction(7 downto 4) = x"8" and instruction(3 downto 2) = "01" )
	or ( instruction(7 downto 4) = x"8" and instruction(3 downto 2) = "10" )
	else '0';
	
	-- set flag_change flag
	flag_change <= '0' when instruction(7 downto 4) = x"7"
	or instruction(7 downto 4) = x"1"
	or instruction(7 downto 4) = x"c"
	or instruction(7 downto 4) = x"d"
	or instruction(7 downto 4) = x"e"
	or instruction(7 downto 4) = x"0"
	else '1';
	
	-- set ra/rb
	ra <= ra_sig;
	rb <= rb_sig;
		
	-- set value#1
	op1 <= r0 when ra_sig = "00" 
	else r1 when ra_sig = "01"
	else r2 when ra_sig = "10"
	else r3; 
	-- set value#2
	op2 <= not r0 when rb_sig = "00" and instruction(7 downto 4) = x"8" and instruction(3 downto 2) = "01"
	else not r1 when rb_sig = "01" and instruction(7 downto 4) = x"8" and instruction(3 downto 2) = "01"
	else not r2 when rb_sig = "10" and instruction(7 downto 4) = x"8" and instruction(3 downto 2) = "01"
	else not r3 when rb_sig = "11" and instruction(7 downto 4) = x"8" and instruction(3 downto 2) = "01"
	else r0 when rb_sig = "00"
	else r1 when rb_sig = "01"
	else r2 when rb_sig = "10"
	else r3;

end decode_arch;
