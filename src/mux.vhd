library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux is
    port(sel:in STD_LOGIC;
         w0:in STD_LOGIC_VECTOR(31 downto 0);
         w1:in STD_LOGIC_VECTOR(31 downto 0);
         output: out STD_LOGIC_VECTOR(31 downto 0)
     );
end mux;

architecture behavioral of mux is
begin
    with sel select
        output <= w0 when '0',
                  w1 when '1',
                  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" when others;
end behavioral;
