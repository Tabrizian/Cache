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
    addr <= std_logic_vector(to_unsigned(52,10)),
            std_logic_vector(to_unsigned(0,10)) after 320 ns,
            std_logic_vector(to_unsigned(1,10)) after 620 ns,
            std_logic_vector(to_unsigned(64,10)) after 920 ns,
            std_logic_vector(to_unsigned(0,10)) after 1220 ns,
            std_logic_vector(to_unsigned(1,10)) after 1520 ns,
            std_logic_vector(to_unsigned(0,10)) after 1820 ns,
            std_logic_vector(to_unsigned(64,10)) after 2120 ns,
            std_logic_vector(to_unsigned(65,10)) after 2420 ns,
            std_logic_vector(to_unsigned(0,10)) after 2720 ns;



    wrdata <= std_logic_vector(to_unsigned(13,32)),
              std_logic_vector(to_unsigned(52,32)) after 320 ns,
              std_logic_vector(to_unsigned(12,32)) after 620 ns,
              std_logic_vector(to_unsigned(4,32)) after 920 ns,
              std_logic_vector(to_unsigned(25,32)) after 2420 ns,
              std_logic_vector(to_unsigned(70,32)) after 2720 ns;



    write <= '1', '0' after 70 ns , '1' after 320 ns , '0' after 370 ns , '1' after 620 ns , '0' after 670 ns ,
             '1' after 920 ns , '0' after 970 ns , '1' after 2420 ns , '0' after 2470 ns , '1' after 2720 ns , '0' after 2770 ns;
    read <= '0', '1' after 1220 ns , '0' after 1270 ns , '1' after 1520 ns , '0' after 1570 ns , '1' after 1820 ns ,
            '0' after 1870 ns , '1' after 2120 ns , '0' after 2170 ns ;

    reset_n <= '0' , '1' after 3020 ns ;

    CLOCK:
    clk <= '1' after 1 ns when clk = '0' else
           '0' after 1 ns when clk = '1';
end test_bench;
