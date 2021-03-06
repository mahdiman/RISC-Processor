LIBRARY ieee;
use ieee.std_logic_1164.all;
use IEEE.math_real.all;
use IEEE.NUMERIC_STD.all;

entity decode is 
	port(
 		instruction : in std_logic_vector(7 downto 0);
		r0, r1, r2, r3, port_in, pc: in std_logic_vector(7 downto 0);
		old_flags : in std_logic_vector(3 downto 0);
		stallIn : in std_logic;
		mode: out std_logic_vector(5 downto 0);
		br_mode : out std_logic_vector(3 downto 0);
		op1, op2 : out std_logic_vector(7 downto 0);
		ra, rb : out std_logic_vector(1 downto 0);
		fa, fb, cin, mem_access, write_back, flag_change, sel_dst: out std_logic;
		conditions : out std_logic_vector(1 downto 0);
		get_from_fetch1, get_from_fetch2, stallOut, get_flags, pc_read, pc_dirty, save_flags, restore_flags: out std_logic
	);
end decode; 

architecture decode_arch OF decode IS
	signal ra_sig, rb_sig : std_logic_vector(1 downto 0);
	signal tmp_instruction : std_logic_vector(7 downto 0);
	signal stall1, stall2 : std_logic;
begin

	tmp_instruction <= instruction when stallIn = '0'
	else "00000000";

	-- get ra
	ra_sig <= tmp_instruction(3 downto 2) 
		when tmp_instruction(7 downto 4) = x"0"
		or	 tmp_instruction(7 downto 4) = x"2"
		or	 tmp_instruction(7 downto 4) = x"3"
		or	 tmp_instruction(7 downto 4) = x"4"
		or	 tmp_instruction(7 downto 4) = x"5"
		or	 tmp_instruction(7 downto 4) = x"9"
		or	 tmp_instruction(7 downto 4) = x"a"
		or	 ( tmp_instruction(7 downto 4) = x"b" and instruction(3 downto 2) = "01" )
		
	else tmp_instruction(1 downto 0) 
		when tmp_instruction(7 downto 4) = x"1"
		or	 tmp_instruction(7 downto 4) = x"6"
		or	 ( tmp_instruction(7 downto 4) = x"7" and tmp_instruction(3 downto 2) = "10" )
		or	 ( tmp_instruction(7 downto 4) = x"7" and tmp_instruction(3 downto 2) = "11" )
		or	 tmp_instruction(7 downto 4) = x"8"
		or   tmp_instruction(7 downto 4) = x"c" 
		or   tmp_instruction(7 downto 4) = x"e"
		or   tmp_instruction(7 downto 4) = x"d"
		or	 ( tmp_instruction(7 downto 4) = x"b" and instruction(3 downto 2) = "00" )
		
	else "11" 
		when ( tmp_instruction(7 downto 4) = x"7" and tmp_instruction(3 downto 2) = "01" ) 
		or	 ( tmp_instruction(7 downto 4) = x"7" and tmp_instruction(3 downto 2) = "00" ) 
		or	 ( tmp_instruction(7 downto 4) = x"b" and tmp_instruction(3 downto 2) = "10" ) 
		or	 ( tmp_instruction(7 downto 4) = x"b" and tmp_instruction(3 downto 2) = "11" ) 
		or	 tmp_instruction(7 downto 0) = x"f0"  
		or	 tmp_instruction(7 downto 0) = x"f1"  
	else "00";

	ra <= ra_sig;
  
  -- set forwarding options
	fa <= '0' 
		when ( tmp_instruction(7 downto 4) = x"6" and tmp_instruction(3 downto 2) = "10" )
		or	 ( tmp_instruction(7 downto 4) = x"6" and tmp_instruction(3 downto 2) = "11" )
		or   ( tmp_instruction(7 downto 4) = x"7" and tmp_instruction(3 downto 2) = "11" )
		or   ( tmp_instruction(7 downto 4) = x"c" and (tmp_instruction(3 downto 2) = "00" or tmp_instruction(3 downto 2) = "01") )
    	or   tmp_instruction(7 downto 4) = x"d"
    	or   tmp_instruction(7 downto 0) = x"f0"
    	or   tmp_instruction(7 downto 0) = x"f1"
	else '1';

	-- get rb
	rb_sig <= tmp_instruction(3 downto 2)
		when tmp_instruction(7 downto 4) = x"1"
		or   tmp_instruction(7 downto 4) = x"c" 
	  	or	 tmp_instruction(7 downto 4) = x"e"
	  	or	 tmp_instruction(7 downto 4) = x"d"
	
	else tmp_instruction(1 downto 0)
		when tmp_instruction(7 downto 4) = x"0"
		or	 tmp_instruction(7 downto 4) = x"2"
		or	 tmp_instruction(7 downto 4) = x"3"
		or	 tmp_instruction(7 downto 4) = x"4"
		or	 tmp_instruction(7 downto 4) = x"5"
		or	 tmp_instruction(7 downto 4) = x"6"
		or	 tmp_instruction(7 downto 4) = x"7"
		or	 tmp_instruction(7 downto 4) = x"8"
		or	 tmp_instruction(7 downto 4) = x"9"
		or	 tmp_instruction(7 downto 4) = x"a"
		or	 ( tmp_instruction(7 downto 4) = x"b" and instruction(3 downto 2) = "00" )
		or	 ( tmp_instruction(7 downto 4) = x"b" and instruction(3 downto 2) = "01" )
		or	 ( tmp_instruction(7 downto 4) = x"b" and instruction(3 downto 2) = "10" )
		or	 ( tmp_instruction(7 downto 4) = x"b" and instruction(3 downto 2) = "11" )

	else "00";

	-- set forwarding for register#2
	fb <= '0' 
		when ( tmp_instruction(7 downto 4) = x"6" and tmp_instruction(3 downto 2) = "10" )
		or	 ( tmp_instruction(7 downto 4) = x"6" and tmp_instruction(3 downto 2) = "11" )
		or  tmp_instruction(7 downto 4) = x"c"		
		or  tmp_instruction(7 downto 0) = x"f0"
		or  tmp_instruction(7 downto 0) = x"f1"
	else '1';

	rb <= rb_sig;

	-- get cin
	cin <= '1' when tmp_instruction(7 downto 4) = x"3"
		or ( tmp_instruction(7 downto 4) = x"7" and tmp_instruction(3 downto 2) = "01" )
		or ( tmp_instruction(7 downto 4) = x"8" and tmp_instruction(3 downto 2) = "01" )
		or ( tmp_instruction(7 downto 4) = x"8" and tmp_instruction(3 downto 2) = "10" )
		or ( tmp_instruction(7 downto 4) = x"b" and tmp_instruction(3 downto 2) = "10" )
		or ( tmp_instruction(7 downto 4) = x"b" and tmp_instruction(3 downto 2) = "11" )
	else '0';

	sel_dst <= '1' when tmp_instruction(7 downto 4) = x"1"
		or ( tmp_instruction(7 downto 4) = x"7" and tmp_instruction(3 downto 2) = "01" )
		or ( tmp_instruction(7 downto 4) = x"7" and tmp_instruction(3 downto 2) = "11" )
	else '0';

	flag_change <= '0' 
		when tmp_instruction(7 downto 4) = x"7"
		or   tmp_instruction(7 downto 4) = x"1"
		or   tmp_instruction(7 downto 4) = x"0"

		or   tmp_instruction(7 downto 4) = x"9"
		or   tmp_instruction(7 downto 4) = x"a"
		or   tmp_instruction(7 downto 4) = x"b"

		or   tmp_instruction(7 downto 4) = x"c"
		or   tmp_instruction(7 downto 4) = x"d"
		or   tmp_instruction(7 downto 4) = x"e"
		or   tmp_instruction(7 downto 0) = x"f0"
		or   tmp_instruction(7 downto 0) = x"f1"
	else '1';


  -- format A modes
	mode <= "000000" when tmp_instruction(7 downto 4) = x"0"
	else 	"000000" when tmp_instruction(7 downto 4) = x"1"
	else 	"000001" when tmp_instruction(7 downto 4) = x"2"
	else 	"000010" when tmp_instruction(7 downto 4) = x"3"
	else 	"000100" when tmp_instruction(7 downto 4) = x"4"
	else 	"000101" when tmp_instruction(7 downto 4) = x"5"
	else 	"001110" when tmp_instruction(7 downto 4) = x"6" and tmp_instruction(3 downto 2) = "00"
	else 	"001010" when tmp_instruction(7 downto 4) = x"6" and tmp_instruction(3 downto 2) = "01"
	else 	"110101" when tmp_instruction(7 downto 4) = x"6" and tmp_instruction(3 downto 2) = "10"
	else 	"110100" when tmp_instruction(7 downto 4) = x"6" and tmp_instruction(3 downto 2) = "11"
	else 	"110011" when tmp_instruction(7 downto 4) = x"7" and tmp_instruction(3 downto 2) = "00"
	else 	"110000" when tmp_instruction(7 downto 4) = x"7" and tmp_instruction(3 downto 2) = "01"
	else 	"000000" when tmp_instruction(7 downto 4) = x"7" and tmp_instruction(3 downto 2) = "10"
	else 	"000000" when tmp_instruction(7 downto 4) = x"7" and tmp_instruction(3 downto 2) = "11"
	else 	"000111" when tmp_instruction(7 downto 4) = x"8" and tmp_instruction(3 downto 2) = "00"
	else 	"000011" when tmp_instruction(7 downto 4) = x"8" and tmp_instruction(3 downto 2) = "01"
	else 	"000000" when tmp_instruction(7 downto 4) = x"8" and tmp_instruction(3 downto 2) = "10"
	else 	"000011" when tmp_instruction(7 downto 4) = x"8" and tmp_instruction(3 downto 2) = "11"
	 
	-- format L modes 
  	else	"010000" when tmp_instruction(7 downto 4) = x"c" and tmp_instruction(3 downto 2) = "00"
	else	"010000" when tmp_instruction(7 downto 4) = x"c" and tmp_instruction(3 downto 2) = "01"
	else	"010000" when tmp_instruction(7 downto 4) = x"c" and tmp_instruction(3 downto 2) = "10"
	else	"010000" when tmp_instruction(7 downto 4) = x"d"
	else	"010000" when tmp_instruction(7 downto 4) = x"e"

	-- format B modes
	else	"100000" when tmp_instruction(7 downto 4) = x"9"
	else	"100011" when tmp_instruction(7 downto 4) = x"a"
	else    "100000" when tmp_instruction(7 downto 4) = x"b" and tmp_instruction(3 downto 2) = "00"
	else	"100011" when tmp_instruction(7 downto 4) = x"b" and tmp_instruction(3 downto 2) = "01"
	else    "110000" when tmp_instruction(7 downto 4) = x"b" and tmp_instruction(3 downto 2) = "10"
	else    "110000" when tmp_instruction(7 downto 4) = x"b" and tmp_instruction(3 downto 2) = "11"
	else	"100000" when tmp_instruction(7 downto 4) = x"d"
	else 	"110011" when tmp_instruction(7 downto 0) = x"f0"
	else 	"110011" when tmp_instruction(7 downto 0) = x"f1"

	else 	"000000";

	-- branch mode
	br_mode <= x"1" when ( instruction(7 downto 4) = x"9" and instruction(3 downto 2) = "00" )
	else x"2" when ( instruction(7 downto 4) = x"9" and instruction(3 downto 2) = "01" )
	else x"3" when ( instruction(7 downto 4) = x"9" and instruction(3 downto 2) = "10" )
	else x"4" when ( instruction(7 downto 4) = x"9" and instruction(3 downto 2) = "11" )
	else x"5" when instruction(7 downto 4) = x"a"
	else x"6" when ( instruction(7 downto 4) = x"b" and instruction(3 downto 2) = "00" )
	--else x"7" when ( instruction(7 downto 4) = x"b" and instruction(3 downto 2) = "01" )
	--else x"8" when ( instruction(7 downto 4) = x"b" and instruction(3 downto 2) = "10" )
	--else x"9" when ( instruction(7 downto 4) = x"b" and instruction(3 downto 2) = "11" )
	else x"0";

	-- get op1
	op1 <= ("0000" & old_flags) when tmp_instruction(7 downto 4) = x"6" and tmp_instruction(3) = '1'
	else port_in when tmp_instruction(7 downto 4) = x"7" and tmp_instruction(3 downto 2) = "11"
	else r0 when ra_sig = "00" 
	else r1 when ra_sig = "01"
	else r2 when ra_sig = "10"
	else r3; 
	
	-- get op2
	op2 <= "00000100" when tmp_instruction(7 downto 4) = x"6" and tmp_instruction(3 downto 2) = "10"
	else "11111011" when tmp_instruction(7 downto 4) = x"6" and tmp_instruction(3 downto 2) = "11"
	else std_logic_vector( unsigned(pc) + 1 ) when instruction(7 downto 0) = x"f0"
	else pc when instruction(7 downto 0) = x"f1"
	else r0 when rb_sig = "00" 
	else r1 when rb_sig = "01"
	else r2 when rb_sig = "10"
	else r3; 

	-- get mem access
	mem_access <= '1' 
		when ( tmp_instruction(7 downto 4) = x"7" and tmp_instruction(3 downto 2) = "00" )
		or	 ( tmp_instruction(7 downto 4) = x"7" and tmp_instruction(3 downto 2) = "01" )
		or   ( tmp_instruction(7 downto 4) = x"c" and ( tmp_instruction(3 downto 2) = "01" or  tmp_instruction(3 downto 2) = "10" ))
		or   tmp_instruction(7 downto 4) = x"d" 
		or   tmp_instruction(7 downto 4) = x"e"
		or   ( tmp_instruction(7 downto 4) = x"b" and instruction(3 downto 2) = "01" )
		or   ( tmp_instruction(7 downto 4) = x"b" and instruction(3 downto 2) = "10" )
		or   ( tmp_instruction(7 downto 4) = x"b" and instruction(3 downto 2) = "11" )
    	or   tmp_instruction(7 downto 0) = x"f0"
    	or   tmp_instruction(7 downto 0) = x"f1"
	else '0';

	write_back <= '0' 
		when tmp_instruction(7 downto 4) = x"0"
		or	 ( tmp_instruction(7 downto 4) = x"6" and tmp_instruction(3 downto 2) = "10" )
		or	 ( tmp_instruction(7 downto 4) = x"6" and tmp_instruction(3 downto 2) = "11" )
		or	 ( tmp_instruction(7 downto 4) = x"7" and tmp_instruction(3 downto 2) = "00" )
		or	 ( tmp_instruction(7 downto 4) = x"7" and tmp_instruction(3 downto 2) = "10" )
    	or   ( tmp_instruction(7 downto 4) = x"c" and tmp_instruction(3 downto 2) = "10")
    	or   tmp_instruction(7 downto 4) = x"e"
    	or   tmp_instruction(7 downto 4) = x"9"
    	or   tmp_instruction(7 downto 4) = x"b"    	
    	or   tmp_instruction(7 downto 0) = x"f0"
    	or   tmp_instruction(7 downto 0) = x"f1"
	else '1';

	conditions <= "01" when ( tmp_instruction(7 downto 4) = x"7" and tmp_instruction(3 downto 2) = "10" ) -- out port
	else "10" 
		when ( tmp_instruction(7 downto 4) = x"7" and tmp_instruction(3) = '0' ) -- SP
		or   ( tmp_instruction(7 downto 0) = x"f0" ) 
		or   ( tmp_instruction(7 downto 0) = x"f1" ) 
		or   ( tmp_instruction(7 downto 4) = x"b" and tmp_instruction(3) = '1' ) 
	else "00";
	  
	stall1 <= '1' when ( tmp_instruction(7 downto 4) = x"c" and tmp_instruction(3 downto 2 ) = "00")
	else '0';
	 
	get_from_fetch1 <= stall1;
	 
  	stall2 <= '1' 
	  	when ( tmp_instruction(7 downto 4) = x"c" and tmp_instruction(3 downto 2) = "10" )
		or 	 ( tmp_instruction(7 downto 4) = x"c" and tmp_instruction(3 downto 2) = "01" )
	else '0';
	  
	get_from_fetch2 <= stall2;
	  
	stallOut <= stall1 or stall2;
	
	get_flags <= '1' when tmp_instruction(7 downto 4) = x"6" and tmp_instruction(3) = '1'
	else '0';
	 
	pc_read <= '1' 
		when ( instruction(7 downto 4) = x"b" and instruction(3 downto 2) = "10" ) 
		or   ( instruction(7 downto 4) = x"b" and instruction(3 downto 2) = "11" ) 
	else '0';  

	pc_dirty <= '0' 
		when instruction(7 downto 0) = x"f0"
		or   instruction(7 downto 0) = x"f1"
		or   instruction(7 downto 4) = x"0"
	else '1'; 

	save_flags <= '1' when instruction(7 downto 0) = x"f1" else '0';

	restore_flags <= '1' when instruction(7 downto 4) = x"b" and instruction(3 downto 2) = "11" else '0';

end decode_arch;