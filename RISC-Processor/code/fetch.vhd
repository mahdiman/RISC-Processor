library ieee;
use ieee.std_logic_1164.all;
use IEEE.math_real.all;
use IEEE.NUMERIC_STD.all;

entity fetch is
	generic (n: integer := 8;
			i: integer := 8);
	port(
		clk, interrupt: in std_logic;
		pc: in std_logic_vector(n-1 downto 0);
		stall: in std_logic;
		instIn : in std_logic_vector(n-1 downto 0);
		instruction: out std_logic_vector (i-1 downto 0);
		pc_incremented : out std_logic_vector(n-1 downto 0);
		ldOut, interrupt_address_en : out std_logic;
		instOut, interrupt_address: out std_logic_vector(n-1 downto 0));
end fetch;

architecture fetch_arch OF fetch IS
	component ram is
		generic (
			n : integer := 8;
			m : integer := 256);
		port (
			clk, we : in std_logic;
			address : in std_logic_vector(integer(ceil(log2(real(m)))) - 1 downto 0);
			datain  : in std_logic_vector(n-1 downto 0);
			dataout : out std_logic_vector(n-1 downto 0));
	end component;
	
	component ndff is
    generic ( n : integer := 8);
    port( clk, rst, init_val, en, flush : in std_logic;
        d : in std_logic_vector(n-1 downto 0);
        q : out std_logic_vector(n-1 downto 0));
  end component;
	
	signal ins, Output : std_logic_vector(i-1 downto 0);
	signal en : std_logic;
begin

	my_ram: ram generic MAP (8, 256) port MAP (clk, '0', pc, (others => '0'), ins);

	instruction <= x"f1" when interrupt = '1'
	else instIn when instIn /= x"00"
	else  x"f0" when ins (7 downto 4) = x"b" and ins( 3 downto 2) = "01"
	else ins when stall = '0' and pc /= x"01" else (others => '0');
	
	instOut <= ( "101100" & ins(1 downto 0) ) when ins (7 downto 4) = x"b" and ins( 3 downto 2) = "01" and instIn = x"00"
	else x"00";
	
	en <= '1' when pc = x"00"
	else '0';
	
	u0: ndff port map (clk, '0', '0', en, '0', ins, Output);
	
	ldOut <= '1' when ins(7 downto 4) = x"d" and stall = '0' and pc /= x"00" and pc /= x"01"
	else '0'; 
		  
	interrupt_address <= ins when pc = x"01" else (others => '0'); 
	interrupt_address_en <= '1' when pc = x"01" else '0';
	
	pc_incremented <= Output when pc = x"01" 
	else pc when ins (7 downto 4) = x"b" and ins( 3 downto 2) = "01" and instIn = x"00"
	else std_logic_vector( unsigned(pc) + 1 ) when stall = '0'
	else ins when stall = '0'
	else pc;

end fetch_arch;