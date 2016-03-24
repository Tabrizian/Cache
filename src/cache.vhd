library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cache is
    port(clk, wren :in STD_LOGIC;
         full_address :in STD_LOGIC_VECTOR(9 downto 0);
         wrdata :in STD_LOGIC_VECTOR(31 downto 0);
         validity :in STD_LOGIC;
         data: out STD_LOGIC_VECTOR(31 downto 0)
     );
end cache;

architecture dataflow of cache is
begin
end dataflow;
