library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity controller is
    port(wr : in STD_LOGIC;
         hit : in STD_LOGIC;
         clk : in STD_LOGIC;
         cache_ready: in STD_LOGIC := '0';
         ram_ready : in STD_LOGIC := '0';
         wr_cache: out STD_LOGIC := '0';
         wr_ram: out STD_LOGIC := '0';
         invalidate : out STD_LOGIC := '0';
         validate : out STD_LOGIC := '1'
     );
end controller;

architecture behavorial of controller is
    constant initial : integer := 0;
    constant begin_write_cache : integer := 1;
    constant s2 : integer := 2;
    constant s3 : integer := 3;
    constant s4 : integer := 4;
    constant s5 : integer := 5;

begin
    process(clk)
        variable current_state : integer := initial;
    begin
        if( current_state = initial) then
            if(wr = '1') then
                wr_ram <= '1';
                wr_cache <= '0';
                validate <= '0';
                invalidate <= '1';
            else
                if(cache_ready = '1') then
                    if (hit = '1') then
                        wr_ram <= '0';
                        wr_cache <= '0';
                        validate <= '1';
                        invalidate <= '0';
                    else
                        wr_ram <= '0';
                        wr_cache <= '1';
                        validate <= '1';
                        invalidate <= '0';
                        current_state := begin_write_cache;
                    end if;
                end if;
            end if;
        elsif( current_state = begin_write_cache) then
            if(cache_ready = '1') then
                current_state := initial;
                wr_cache <= '0';
                validate <= '0';
                invalidate <= '0';
            end if;
        end if;
    end process;
end behavorial;
