Library ieee;
Use ieee.std_logic_1164.all;
entity Alu is  
    generic (n : integer := 8);
    port (a : in std_logic_vector (n-1 downto 0);
        b : in std_logic_vector (n-1 downto 0);
        old_flags : in std_logic_vector(3 downto 0);
        alu_mode : in std_logic_vector(3 downto 0);
        cin : in std_logic;
        result : out std_logic_vector (n-1 downto 0);
        alu_flags : out std_logic_vector(3 downto 0) );    
end entity Alu;

architecture  Alu_DataFlow of Alu is
    component partA is	
        generic (n : integer := 8);
        port (a : in std_logic_vector (n-1 downto 0);
            b : in std_logic_vector (n-1 downto 0);
            s1, s0, cin : in std_logic;
            F : out std_logic_vector (n-1 downto 0);
            cout, overFlow : out std_logic );    
    end component;
  component partB is
    generic (n : integer := 8);
    port (a : in std_logic_vector (n-1 downto 0);
        b : in std_logic_vector (n-1 downto 0);
        s0, s1, cin, ov : in std_logic ;
        F : out std_logic_vector (n-1 downto 0);
        cout, overFlow : out std_logic );    
  end component;  
  
    component partC  is  
        generic (n : integer := 8);
    port (a : in std_logic_vector (n-1 downto 0);
        s0, s1, cin, ov : in std_logic ;
        F : out std_logic_vector (n-1 downto 0);	
	   cout, overFlow : out std_logic );     
    end component;

    component partD  is  
         generic (n : integer := 8);
    port (a : in std_logic_vector (n-1 downto 0);
        s0, s1, cin, ov : in std_logic ;
        F : out std_logic_vector (n-1 downto 0);
    	cout, overFlow : out std_logic );   
    end component;

    signal res1 : std_logic_vector(n-1 downto 0);
    signal res2 : std_logic_vector(n-1 downto 0);
    signal res3 : std_logic_vector(n-1 downto 0);
    signal res4 : std_logic_vector(n-1 downto 0);

    signal s3 , s2 , s1 , s0 : std_logic;

    signal c1, ov1, c2, ov2, c3, ov3, c4, ov4 : std_logic;
    signal Fout : std_logic_vector(n-1 downto 0);

    signal old_c, old_ov : std_logic;

begin

    s3 <= alu_mode(3);
    s2 <= alu_mode(2);
    s1 <= alu_mode(1);
    s0 <= alu_mode(0);

    old_c <= old_flags(2);
    old_ov <= old_flags(3);

    u0 : partA generic map (n) port map (a, b, s1, s0, cin, res1, c1, ov1);
    u1 : partB port map (a, b, s0, s1, old_c, old_ov, res2, c2, ov2);
    u2 : partC port map (a, s0, s1, old_c, old_ov, res3, c3, ov3);
    u3 : partD port map (a, s0, s1, old_c, old_ov, res4, c4, ov4);

    Fout <= res1 when s3 = '0' and s2 = '0'
    else res2 when s3 = '0' and s2 = '1'
    else res3 when s3 = '1' and s2 = '0'
    else res4;

    result <= Fout;

    -- N : Negative --
    alu_flags(1) <= old_flags(1) when s3 = '1' else Fout(n-1);

    -- Z : Zero --
    alu_flags(0) <= old_flags(0) when s3 = '1' 
    else '1' when Fout = (n-1 downto 0 => '0') else '0';

    -- Carry --
    alu_flags(2) <= c1 when s3 = '0' and s2 = '0'
    else c2 when s3 = '0' and s2 = '1'
    else c3 when s3 = '1' and s2 = '0'
    else c4; 

    -- OverFlow --
    alu_flags(3) <=  old_flags(3) when s3 = '1' 
    else ov1 when s3 = '0' and s2 = '0'
    else ov2 when s3 = '0' and s2 = '1'
    else ov3 when s3 = '1' and s2 = '0'
    else ov4;

end Alu_DataFlow;