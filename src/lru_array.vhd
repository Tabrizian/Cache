library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity lru_array is
    port(address : in STD_LOGIC_VECTOR(5 downto 0);
         k : in STD_LOGIC;
         clk : in STD_LOGIC;
         enable : in STD_LOGIC;
         reset : in STD_LOGIC;
         w0_valid : out STD_LOGIC
     );
end entity;

architecture behavorial of lru_array is
    type data_array is array (63 downto 0) of integer;
    signal w0s : data_array := (others => 0);
    signal w1s : data_array := (others => 0);
    signal last_address : STD_LOGIC_VECTOR(5 downto 0);
    signal last_k : STD_LOGIC;
begin
    process (clk)
    begin
        if(reset = '1') then
            if(k = '0') then
                w0s(to_integer(unsigned(address))) <= 0;
            else
                w1s(to_integer(unsigned(address))) <= 0;
            end if;
            last_address <= "ZZZZZZ";
            last_k <= 'Z';
        elsif(enable = '1') then
            if(k = '0' and (last_address /= address or k /= last_k)) then
                w0s(to_integer(unsigned(address))) <= w0s(to_integer(unsigned(address))) + 1;
                last_address <= address;
                last_k <= k;
            elsif(k = '1' and (last_address /= address or k /= last_k)) then
                w1s(to_integer(unsigned(address))) <= w1s(to_integer(unsigned(address))) + 1;
                last_address <= address;
                last_k <= k;
            end if;

            if(w0s(to_integer(unsigned(address))) <= w1s(to_integer(unsigned(address)))) then
                                                     w0_valid <= '1';
                                                 else
                                                     w0_valid <= '0';
                                                 end if;
        end if;

    end process;
end behavorial;
