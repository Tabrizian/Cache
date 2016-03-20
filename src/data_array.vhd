LIBRARY IEEE;
use IEEE.std_logic_1164.all;

entity data_array is
    port(clk, wren:in STD_LOGIC;
         address:in STD_LOGIC_VECTOR(5 downto 0);
         wrdata:in STD_LOGIC_VECTOR(63 downto 0);
         data:in STD_LOGIC_VECTOR(63 downto 0));
end data_array;

architecture gate_level_data_array of data_array is
    component data_array is
        port(clk, wren:in STD_LOGIC;
             address:in STD_LOGIC_VECTOR(5 downto 0);
             wrdata:in STD_LOGIC_VECTOR(63 downto 0);
             data:in STD_LOGIC_VECTOR(63 downto 0));
    end component;

begin

end gate_level_data_array;
