library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity miss_hit_logic_tb is
    end miss_hit_logic_tb;

architecture behavorial of miss_hit_logic_tb is
    component miss_hit_logic is
        port(tag : in STD_LOGIC_VECTOR(3 downto 0);
             w0 : in STD_LOGIC_VECTOR(4 downto 0);
             w1 : in STD_LOGIC_VECTOR(4 downto 0);
             hit : out STD_LOGIC;
             w0_valid : out STD_LOGIC;
             w1_valid : out STD_LOGIC
         );
    end component;

    signal tag : STD_LOGIC_VECTOR(3 downto 0);
    signal w0,w1 : STD_LOGIC_VECTOR(4 downto 0);
    signal hit,w0_valid,w1_valid : STD_LOGIC;

begin
    mapping: miss_hit_logic port map(tag,w0,w1,hit,w0_valid,w1_valid);

    tag <= "0100";
    w0 <= "10111";
    w1 <= "10100";

end behavorial;
