Library ieee;
Use ieee.std_logic_1164.all;
entity partC  is  
    generic (n : integer := 8);
    port (a : in std_logic_vector (n-1 downto 0);
        s0, s1, cin, ov : in std_logic ;
        F : out std_logic_vector (n-1 downto 0);	
	   cout, overFlow : out std_logic );    
end entity partC ;

    --+----+----+-----------+
    --| s1 | s0 | F         |  
    --+----+----+-----------+
    --| 0  | 0  | LSR       |
    --| 0  | 1  | RR        |
    --| 1  | 0  | RRC       |
    --| 1  | 1  | ASR       |
    --+----+----+-----------+

architecture  partC_DataFlow of partC is

    signal c_tmp : std_logic;
    signal Fout : std_logic_vector(n-1 downto 0);
  
begin
    Fout(n-1 downto 0) <= '0' & a(n-1 downto 1) when s0 = '0' and s1 ='0' 
    else a(0) & a(n-1 downto 1) when  s0 = '1' and s1 ='0'
    else cin & a(n-1 downto 1) when s0 = '0' and s1 ='1'
    else a(n-1) & a(n-1 downto 1);

    c_tmp <= a(0) when s0 = '1' or s1 <= '1' else cin;           -- RR | ASR --

    overFlow <= Fout(n-1) xor c_tmp when s0 = '1'	-- ROR | ASR --
    else a(n-1) when s0 = '0' and s1 = '0'		    -- RRC --
    else ov;

    cout <= c_tmp;
    F <= Fout;
end partC_DataFlow;