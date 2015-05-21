library ieee;
use ieee.std_logic_1164.all;

entity ndff is
    generic ( n : integer := 8);
    port( clk, rst, init_val, en, flush : in std_logic;
        d : in std_logic_vector(n-1 downto 0);
        q : out std_logic_vector(n-1 downto 0));
end ndff;

architecture ndff_arch of ndff is
begin
    process(clk, rst, en, flush)
    begin
    if(rst = '1') then
        q <= (others => init_val);
    elsif rising_edge( clk ) then
        if flush = '1' then
            q <= (others => '0');
        elsif en = '1' then
            q <= d;
        end if;
    end if;
    end process;
end ndff_arch;