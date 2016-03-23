LIBRARY ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity data_array is
    port(clk, wr:in STD_LOGIC;
         -- Address size is equal to index * 2 + tag
         address:in STD_LOGIC_VECTOR(10 downto 0);
         data_in:in STD_LOGIC_VECTOR(31 downto 0);
         data_out:out STD_LOGIC_VECTOR(31 downto 0));
end data_array;

architecture behavorial_data_array of data_array is
    type data_array_data is array (2047 downto 0) of STD_LOGIC_VECTOR (31 downto 0);
    signal data_array : data_array_data;
begin
    process(clk)
    begin
        if(wr = '1') then
            data_array(to_integer(unsigned(address))) <= data_in;
        end if;

        data_out <= data_array(to_integer(unsigned(address)));
    end process;

end behavorial_data_array;
