library IEEE;
use IEEE.std_logic_1164.all;

entity tag_valid_array is
    port(clk,reset_n,invalidate:in STD_LOGIC;
         address:in STD_LOGIC_VECTOR(5 downto 0);
         wrdata:in STD_LOGIC_VECTOR(3 downto 0)
     );
end tag_valid_array;
