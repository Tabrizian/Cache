library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cache_ram is
    port(reset_n,clk,read,write: in STD_LOGIC;
         addr : in STD_LOGIC_VECTOR(9 downto 0);
         wrdata: in STD_LOGIC_VECTOR(31 downto 0);
         rddata: out STD_LOGIC_VECTOR(31 downto 0);
         hit: out STD_LOGIC
     );
end cache_ram;
