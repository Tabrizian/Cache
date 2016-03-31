LIBRARY ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ram is
    port(clk, wr:in STD_LOGIC;
         -- Address size is equal to index + tag
         address:in STD_LOGIC_VECTOR(9 downto 0);
         data_in:in STD_LOGIC_VECTOR(31 downto 0);
         data_out:out STD_LOGIC_VECTOR(31 downto 0);
         ram_ready:out STD_LOGIC := '0'
     );
end ram;

architecture behavorial_data_array of ram is
    type data_array_data is array (1023 downto 0) of STD_LOGIC_VECTOR (31 downto 0);
    signal data_array : data_array_data;
begin
    data_out <= data_array(to_integer(unsigned(address)));

    process(clk)
    begin
        ram_ready <= '0';
        if(wr = '1') then
            data_array(to_integer(unsigned(address))) <= data_in;
        end if;

        ram_ready <= '1';

    end process;

end behavorial_data_array;
