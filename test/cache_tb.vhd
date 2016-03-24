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
             validate, invalidate:in STD_LOGIC;
             data: out STD_LOGIC_VECTOR(31 downto 0);
             hit: out STD_LOGIC
    );
    end component;
    signal clk : STD_LOGIC := '0';
    signal wren, reset_n : STD_LOGIC;
    signal full_address : STD_LOGIC_VECTOR(9 downto 0);
    signal wrdata : STD_LOGIC_VECTOR(31 downto 0);
    signal validate, invalidate: STD_LOGIC;
    signal data: STD_LOGIC_VECTOR(31 downto 0);
    signal hit: STD_LOGIC;
begin
    mapping : cache port map(clk,wren,reset_n,full_address,wrdata,validate,invalidate,data,hit);

    full_address <= STD_LOGIC_VECTOR(to_unsigned(0,10)) after 0 ns,
                    STD_LOGIC_VECTOR(to_unsigned(45,10)) after 1 ns,
                    STD_LOGIC_VECTOR(to_unsigned(0,10)) after 2 ns;
    wren <= '1' after 0 ns, '0' after 2 ns;
    wrdata <= STD_LOGIC_VECTOR(to_unsigned(9, 32)) after 0 ns,
              STD_LOGIC_VECTOR(to_unsigned(24,32)) after 1 ns;
    reset_n <= '0' after 0 ns;
    validate <= '1' after 0 ns;
    invalidate <= '0' after 0 ns;

    CLOCK:
    clk <= '1' after 1 ns when clk = '0' else
           '0' after 1 ns when clk = '1';
end test_bench;
