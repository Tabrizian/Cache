library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tag_valid_array is
    port(clk,wren,reset_n,invalidate:in STD_LOGIC;
         address:in STD_LOGIC_VECTOR(5 downto 0);
         wrdata:in STD_LOGIC_VECTOR(3 downto 0);
         output:out STD_LOGIC_VECTOR(4 downto 0)
     );
end tag_valid_array;

architecture behavorial of tag_valid_array is

    type data_array_data is array (63 downto 0) of STD_LOGIC_VECTOR (4 downto 0);
    signal data_array : data_array_data;
begin
    process(clk)
    begin
        if(wren = '1') then
            output(4 downto 1) <= wrdata;
            output(0) <= data_array(to_integer(unsigned(address)))(0);
            data_array(to_integer(unsigned(address)))(4 downto 1) <= wrdata;
        else
            output <= data_array(to_integer(unsigned(address)));
        end if;

    end process;
end behavorial;
