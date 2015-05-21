Library ieee;
Use ieee.std_logic_1164.all;

entity partA is  
    generic (n : integer := 8);
    port ( a : in std_logic_vector (n-1 downto 0);
        b : in std_logic_vector (n-1 downto 0);
        s1, s0, cin : in std_logic;
        F : out std_logic_vector (n-1 downto 0);
        cout, overFlow : out std_logic);    
end entity partA ;

    --+----+----+-----+---------+
    --| s1 | s0 | cin | F       |
    --+----+----+-----+---------+
    --| 0  | 0  |  0  | A       |
    --| 0  | 0  |  1  | A+1     |
    --| 0  | 1  |  0  | A+B     |
    --| 0  | 1  |  1  | A+B+1   |
    --| 1  | 0  |  0  | A-B-1   |
    --| 1  | 0  |  1  | A-B     |
    --| 1  | 1  |  0  | A-1     |
    --| 1  | 1  |  1  | 0       |
    --+----+----+-----+---------+

architecture  partA_DataFlow of partA is
  
    -- includes 
    component my_nadder is	
        generic (n : integer := 8);
        port( a, b : in std_logic_vector(n-1  downto 0);
            cin : in std_logic;  
            s : out std_logic_vector(n-1 downto 0);    
            cout, Oc : out std_logic);  
    end component;

    signal aa, bb, notB, notA : std_logic_vector(n-1 downto 0);
    signal cc, cc_out, Ovc : std_logic;

begin 

    notB <= not b;
    notA <= not a;

    aa <= notA when s1 = '1' and s0 = '1' and cin = '1' 
    else a;

    bb <= b when s1 = '0' and s0 = '1'
    else  notB when s1 = '1' and s0 = '0'
    else (others => '1') when s1 = '1' and s0 = '1' and cin = '0'
    else (others => '0');  

    cc <= '1' when (s1 = '0' and cin = '1') or (s0 = '0' and cin = '1') or (s1 = '1' and s0 = '1' and cin = '1')
    else '0';

    u7: my_nadder generic map (n) port map (aa, bb, cc, F, cc_out, Ovc);    

    overFlow <= '0' when s1 = '1' and s0 = '1'
    else cc_out xor Ovc;   

    cout <= not cc_out when ( s1='1' and s0='0' ) or ( s1='1' and s0='1' and cin = '0' ) else cc_out;

end partA_DataFlow;