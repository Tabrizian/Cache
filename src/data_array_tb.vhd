library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_array_tb is

    end data_array_tb;

architecture test_bench of data_array_tb is

    component data_array is
        port(clk, wren:in STD_LOGIC;
             address:in STD_LOGIC_VECTOR(5 downto 0);
             wrdata:in STD_LOGIC_VECTOR(31 downto 0);
             data:out STD_LOGIC_VECTOR(31 downto 0));
    end component;

    signal clk : STD_LOGIC := '0';
    signal wren :STD_LOGIC;
    signal wrdata, data :STD_LOGIC_VECTOR(31 downto 0);
    signal address :STD_LOGIC_VECTOR(5 downto 0);

begin
    mapping: data_array port map(clk, wren, address, wrdata, data);

    address <= "000000";
    wren <= '1';
    wrdata <= STD_LOGIC_VECTOR(to_unsigned(9,32));

    CLOCK:
    clk <= '1' after 1 ns when clk = '0' else
             '0' after 1 ns when clk = '1';
end test_bench;