LIBRARY ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity data_array is
    port(clk, wren:in STD_LOGIC;
         address:in STD_LOGIC_VECTOR(5 downto 0);
         wrdata:in STD_LOGIC_VECTOR(31 downto 0);
         data:out STD_LOGIC_VECTOR(31 downto 0));
end data_array;

architecture behavorial_data_array of data_array is
    --   component data_array is
    --       port(clk, wren:in STD_LOGIC;
    --            address:in STD_LOGIC_VECTOR(5 downto 0);
    --            wrdata:in STD_LOGIC_VECTOR(63 downto 0);
    --            data:in STD_LOGIC_VECTOR(63 downto 0));
    --   end component;
    type data_array_data is array (63 downto 0) of STD_LOGIC_VECTOR (31 downto 0);
    signal data_array : data_array_data;
begin
    data <= data_array(to_integer(unsigned(address)));
    process(clk)
    begin
        if(wren = '1') then
            data_array(to_integer(unsigned(address))) <= wrdata;
        end if;

    end process;

end behavorial_data_array;
