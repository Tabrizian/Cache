library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity lru_array is
    port(address : in STD_LOGIC_VECTOR(5 downto 0);
         update : in STD_LOGIC;
         clk : in STD_LOGIC;
         valid : out STD_LOGIC
     );
end entity;

architecture behavorial of lru_array is
    type data_array is array (63 downto 0) of STD_LOGIC_VECTOR(3 downto 0);
    signal count_status : data_array;
begin
    process (clk)
        variable max : integer := 0;
        variable k : integer := 0;
    begin
        if(update = '1') then
            count_status(to_integer(unsigned(address))) <=
           STD_LOGIC_VECTOR(unsigned(count_status(to_integer(unsigned(address)))) + 1);
       else
           for k in 1 to 63 loop
               if(count_status(k) > count_status(max)) then
                   max := k;
               end if;
           end loop;
       end if;
       if(max = to_integer(unsigned(address))) then
           valid <= '1';
       else
           valid <= '0';
       end if;
   end process;
   end behavorial;
