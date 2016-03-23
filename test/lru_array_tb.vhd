library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity lru_array_tb is
    end lru_array_tb;

architecture test_bench of lru_array_tb is

    component lru_array is
        port(address : in STD_LOGIC_VECTOR(5 downto 0);
             k : in STD_LOGIC;
             update : in STD_LOGIC;
             clk : in STD_LOGIC;
             w0_valid : out STD_LOGIC
         );
    end component;
    signal address : STD_LOGIC_VECTOR(5 downto 0);
    signal k,update,w0_valid : STD_LOGIC;
    signal clk : STD_LOGIC := '0';
begin
    mapping: lru_array port map(address,k,update,clk,w0_valid);

    address <= "000000" after 0 ns;
    update <= '1' after 0 ns, '0' after 2 ns;
    k <= '1';

    CLOCK:
    clk <= '1' after 1 ns when clk = '0' else
           '0' after 1 ns when clk = '1';
end test_bench;
