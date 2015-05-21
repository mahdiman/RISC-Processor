Library ieee;
Use ieee.std_logic_1164.all;

entity partB is
    generic (n : integer := 8);
    port (a : in std_logic_vector (n-1 downto 0);
        b : in std_logic_vector (n-1 downto 0);
        s0, s1, cin, ov : in std_logic ;
        F : out std_logic_vector (n-1 downto 0);
        cout, overFlow : out std_logic );    
end entity partB;  

    --+----+----+---------+
    --| s1 | s0 | F       |
    --+----+----+---------+
    --| 0  | 0  | A & B   |
    --| 0  | 1  | A | B   |
    --| 1  | 0  | A ^ B   |
    --| 1  | 1  | NOT A   |
    --+----+----+---------+

architecture archB of partB is
  begin
    F <= a and b when s0 = '0' and s1 = '0'
    else a or  b when s0 = '1' and s1 = '0'
    else a xor b when s0 = '0' and s1 = '1'
    else not a;

    cout <= cin;
    overFlow <= '0';
end archB;