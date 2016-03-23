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
    process
    begin
        if (w0(0) = '1' and w0(4 downto 1) = tag) then
            hit <= '1';
            w0_valid <= '1';
        elsif(w1(0) = '1' and w1(4 downto 1) = tag) then
            hit <= '1';
            w1_valid <= '1';
        else
            hit <= '0';
            w1_valid <= '0';
            w0_valid <= '0';
        end if;
    end process;
end behavorial;

