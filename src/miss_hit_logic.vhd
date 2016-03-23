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

architecture gate_level of miss_hit_logic is
    signal equal_w0: STD_LOGIC_VECTOR(3 downto 0);
    signal equal_w1: STD_LOGIC_VECTOR(3 downto 0);
    signal is_w0: STD_LOGIC;
    signal is_w1: STD_LOGIC;
begin
    equal_w0 <= w0(3 downto 0) xnor tag;
    equal_w1 <= w1(3 downto 0) xnor tag;
    is_w0 <= equal_w0(3) and equal_w0(2) and equal_w0(1) and equal_w0(0);
    is_w1 <= equal_w1(3) and equal_w1(2) and equal_w1(1) and equal_w1(0);
    w0_valid <= is_w0 and w0(4);
    w1_valid <= is_w1 and w1(4);
    hit <= (is_w0 and w0(4)) or (is_w1 and w1(4));
end gate_level;

