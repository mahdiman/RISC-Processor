Library ieee;
Use ieee.std_logic_1164.all;

entity partD  is  
    generic (n : integer := 8);
    port (a : in std_logic_vector (n-1 downto 0);
        s0, s1, cin, ov : in std_logic ;
        F : out std_logic_vector (n-1 downto 0);
    	cout, overFlow : out std_logic );    
end entity partD ;

    --+----+----+-----------+
    --| s1 | s0 | F         |  
    --+----+----+-----------+
    --| 0  | 0  | LSL       |
    --| 0  | 1  | RL        |
    --| 1  | 0  | RLC       |
    --| 1  | 1  | ASL       |
    --+----+----+-----------+

architecture  partD_DataFlow of partD is
    signal Fout : std_logic_vector(n-1 downto 0);
    signal c_tmp : std_logic;

begin
    Fout(n-1 downto 0) <= a(n-2 downto 0) & '0' when s0 = '0' and s1 ='0' 
    else a(n-2 downto 0) & a(n-1) when  s0 = '1' and s1 ='0'
    else a(n-2 downto 0) & cin when s0 = '0' and s1 ='1'
    else a(n-1) & a(n-3 downto 0) & '0';

    c_tmp <= a(n-1) when s0 = '1' or s1 = '1' else cin;   -- RLC | RL | ASL --

    overFlow <= Fout(n-1) xor c_tmp when s0 = '1'       -- RL | ASL --
    else a(n-1) xor a(n-2) when s0 = '0' and s1 = '0'	-- RLC --
    else ov;

    cout <= c_tmp;
    F <= Fout;
end partD_DataFlow;