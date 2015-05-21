Library ieee;

entity mux4 is 
  port (a,b,c,d,s0,s1 : in bit ;
	y : out bit);
end entity mux4;

-- take care of the usage of when else 
architecture  Data_flow of mux4 is
begin
     y <= a WHEN s0 = '0' and s1 ='0'
       ELSE b WHEN s0 = '0' and s1 ='1'
       ELSE c WHEN s0 = '1' and s1 ='0'
       ELSE d;
end Data_flow;
