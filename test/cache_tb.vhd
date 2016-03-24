library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cache_tb is
    end cache_tb;

architecture test_bench of cache_tb is
    component cache is
        port(clk, wren, reset_n :in STD_LOGIC;
             full_address :in STD_LOGIC_VECTOR(9 downto 0);
             wrdata :in STD_LOGIC_VECTOR(31 downto 0);
             validity :in STD_LOGIC;
             data: out STD_LOGIC_VECTOR(31 downto 0);
             hit: out STD_LOGIC
         );
    end component;
    signal clk, wren, reset_n : STD_LOGIC;
    signal full_address : STD_LOGIC_VECTOR(9 downto 0);
    signal wrdata : STD_LOGIC_VECTOR(31 downto 0);
    signal validity : STD_LOGIC;
    signal data: STD_LOGIC_VECTOR(31 downto 0);
    signal hit: STD_LOGIC;
begin
end test_bench;
