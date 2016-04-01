library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cache_ram_tb is
    end entity;

architecture test_bench of cache_ram_tb is
    component cache_ram is
        port(reset_n,clk,read,write: in STD_LOGIC;
             addr : in STD_LOGIC_VECTOR(9 downto 0);
             wrdata: in STD_LOGIC_VECTOR(31 downto 0);
             rddata: out STD_LOGIC_VECTOR(31 downto 0);
             hit: out STD_LOGIC
         );
    end component;

    signal clk : STD_LOGIC := '0';
    signal reset_n, read, write : STD_LOGIC;
    signal addr: STD_LOGIC_VECTOR(9 downto 0);
    signal wrdata,rddata : STD_LOGIC_VECTOR(31 downto 0);
    signal hit : STD_LOGIC;

begin
    mapping : cache_ram port map (reset_n, clk, read, write, addr, wrdata,
    rddata, hit);

    addr <= STD_LOGIC_VECTOR(to_unsigned(0,10)),
            STD_LOGIC_VECTOR(to_unsigned(13,10)) after 5 ns,
            STD_LOGIC_VECTOR(to_unsigned(0,10)) after 10 ns;

    wrdata <= STD_LOGIC_VECTOR(to_unsigned(56,10)),
              STD_LOGIC_VECTOR(to_unsigned(98,10)) after 5 ns;
    write <= '1', '0' after 10 ns;
    read <= '0', '1' after 10 ns;
    reset_n <= '0';

    CLOCK:
    clk <= '1' after 1 ns when clk = '0' else
           '0' after 1 ns when clk = '1';
end test_bench;
