library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity controller is
    port(write : in STD_LOGIC;
         read: in STD_LOGIC;
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
    constant started_cache_write : integer := 2;
begin
    process(clk)
        variable current_state : integer := initial;
    begin
        if( current_state = initial) then
            if(write = '1' and read = '0') then
                wr_ram <= '1';
                wr_cache <= '0';
                validate <= '0';
                if(hit = '1') then
                    invalidate <= '1';
                end if;
            elsif(write = '0' and read = '1') then
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
            else
                wr_ram <= '0';
                wr_cache <= '0';
                validate <= '0';
                invalidate <= '0';

            end if;
        elsif( current_state = begin_write_cache) then
            if(cache_ready = '1') then
                current_state := started_cache_write;
                wr_cache <= '1';
                validate <= '1';
                invalidate <= '0';
                wr_ram <= '0';
            end if;

        elsif( current_state = started_cache_write ) then
            if(cache_ready = '1') then
                current_state := initial;
                wr_cache <= '1';
                validate <= '1';
                wr_ram <= '0';
                invalidate <= '0';
            end if;
        end if;
    end process;
end behavorial;
