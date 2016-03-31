library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tag_valid_array is
    port(clk,wren,reset_n,invalidate,validate:in STD_LOGIC;
         address:in STD_LOGIC_VECTOR(5 downto 0);
         wrdata:in STD_LOGIC_VECTOR(3 downto 0);
         output:out STD_LOGIC_VECTOR(4 downto 0)
     );
end tag_valid_array;

architecture behavorial of tag_valid_array is

    type data_array_data is array (63 downto 0) of STD_LOGIC_VECTOR(4 downto 0);
    signal data_array : data_array_data := (others => STD_LOGIC_VECTOR(to_unsigned(0,5)));
begin
    output <= data_array(to_integer(unsigned(address)));
    process(clk)
    begin
        if(wren = '1') then
            data_array(to_integer(unsigned(address)))(3 downto 0) <= wrdata;
        end if;

        if(reset_n = '1') then
            data_array <= (others => STD_LOGIC_VECTOR(to_unsigned(0,5)));
        end if;

        if(validate = '1' and wren = '1') then
            data_array(to_integer(unsigned(address)))(4) <= '1';
        end if;

        if(invalidate ='1') then
            data_array(to_integer(unsigned(address)))(4) <= '0';
        end if;

    end process;
end behavorial;
