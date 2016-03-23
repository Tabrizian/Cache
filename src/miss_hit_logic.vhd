library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity miss_hit_logic is
    port(tag : in STD_LOGIC_VECTOR(3 downto 0);
         w0 : in STD_LOGIC_VECTOR(4 downto 0);
         w1 : in STD_LOGIC_VECTOR(4 downto 0);
         hit : out STD_LOGIC;
         w0_valid : out STD_LOGIC;
         w1_valid : out STD_LOGIC
     );
end miss_hit_logic;

architecture behavorial of miss_hit_logic is
begin
    if w0 = "00000" then
        end if;
end behavorial;

