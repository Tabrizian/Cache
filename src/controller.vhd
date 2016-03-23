library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity controller is
    port(write : in STD_LOGIC;
         read : in STD_LOGIC;
         address : in STD_LOGIC_VECTOR;
         clk : in STD_LOGIC;
         wr_data: in STD_LOGIC_VECTOR
     );
end controller;

architecture behavorial of controller is
    constant s0 : integer := 0;
    constant s1 : integer := 1;
    constant s2 : integer := 2;
    constant s3 : integer := 3;
    constant s4 : integer := 4;
    constant s5 : integer := 5;
begin
    process(clk)
        variable state: integer := s0;
    begin
    end process;
end behavorial;
