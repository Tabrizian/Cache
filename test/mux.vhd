library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux_tb is
    end entity;

architecture test_bench of mux_tb is
    component mux is
        port(sel:in STD_LOGIC;
             w0:in STD_LOGIC_VECTOR(31 downto 0);
             w1:in STD_LOGIC_VECTOR(31 downto 0);
             output: out STD_LOGIC_VECTOR(31 downto 0)
         );
    end component;
    signal sel: STD_LOGIC;
    signal w0: STD_LOGIC_VECTOR(31 downto 0);
    signal w1: STD_LOGIC_VECTOR(31 downto 0);
    signal output: STD_LOGIC_VECTOR(31 downto 0);
begin
    mapping : mux port map(sel,w0,w1,output);
    sel <= '0';
    w0 <= STD_LOGIC_VECTOR(to_unsigned(25,32));
    w1 <= STD_LOGIC_VECTOR(to_unsigned(78,32));
end test_bench;
