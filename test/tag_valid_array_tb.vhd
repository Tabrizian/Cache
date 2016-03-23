library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tag_valid_array_tb is
    end tag_valid_array_tb;

architecture test_bench of tag_valid_array_tb is

    component tag_valid_array is
        port(clk,wren,reset_n,validate,invalidate:in STD_LOGIC;
             address:in STD_LOGIC_VECTOR(5 downto 0);
             wrdata:in STD_LOGIC_VECTOR(3 downto 0);
             output:out STD_LOGIC_VECTOR(4 downto 0)
         );
    end component;

    signal clk : STD_LOGIC := '0';
    signal wren,reset_n,invalidate,validate : STD_LOGIC;
    signal wrdata : STD_LOGIC_VECTOR(3 downto 0);
    signal address : STD_LOGIC_VECTOR(5 downto 0);
    signal output : STD_LOGIC_VECTOR(4 downto 0);

begin
    mapping: tag_valid_array port map(clk,wren,reset_n,invalidate,validate,address,wrdata,output);

    address <= "000000" after 0 ns, "111111" after 10 ns, "000000" after 20 ns;
    wren <= '1' after 0 ns, '0' after 20 ns;

    wrdata <= STD_LOGIC_VECTOR(to_unsigned(9, 4)) after 0 ns,
              STD_LOGIC_VECTOR(to_unsigned(7, 4)) after 10 ns;

    reset_n <= '0';
    invalidate <= '0';
    validate <= '1';
    CLOCK:
    clk <= '1' after 1 ns when clk = '0' else
             '0' after 1 ns when clk = '1';
end test_bench;
