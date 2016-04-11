library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cache is
    port(clk, wren, reset_n :in STD_LOGIC;
         full_address :in STD_LOGIC_VECTOR(9 downto 0);
         wrdata :in STD_LOGIC_VECTOR(31 downto 0);
         validate : in STD_LOGIC;
         invalidate :in STD_LOGIC;
         data: out STD_LOGIC_VECTOR(31 downto 0);
         hit: out STD_LOGIC;
         cache_ready: out STD_LOGIC := '1'
     );
end cache;

architecture gate_level of cache is
    component data_array is
        port(clk, wren:in STD_LOGIC;
             address:in STD_LOGIC_VECTOR(5 downto 0);
             wrdata:in STD_LOGIC_VECTOR(31 downto 0);
             data:out STD_LOGIC_VECTOR(31 downto 0)
         );
    end component;

    component tag_valid_array is
        port(clk,wren,reset_n,validate,invalidate:in STD_LOGIC;
             address:in STD_LOGIC_VECTOR(5 downto 0);
             wrdata:in STD_LOGIC_VECTOR(3 downto 0);
             output:out STD_LOGIC_VECTOR(4 downto 0)
         );
    end component;

    component lru_array is
        port(address : in STD_LOGIC_VECTOR(5 downto 0);
             k : in STD_LOGIC;
             clk : in STD_LOGIC;
             enable : in STD_LOGIC;
             reset : in STD_LOGIC;
             w0_valid : out STD_LOGIC
         );
    end component;

    component miss_hit_logic is
        port(tag : in STD_LOGIC_VECTOR(3 downto 0);
             w0 : in STD_LOGIC_VECTOR(4 downto 0);
             w1 : in STD_LOGIC_VECTOR(4 downto 0);
             hit : out STD_LOGIC;
             w0_valid : out STD_LOGIC;
             w1_valid : out STD_LOGIC
         );
    end component;

    component mux is
        port(sel:in STD_LOGIC;
             w0:in STD_LOGIC_VECTOR(31 downto 0);
             w1:in STD_LOGIC_VECTOR(31 downto 0);
             output: out STD_LOGIC_VECTOR(31 downto 0)
         );
    end component;

    type data_array_data is array (63 downto 0) of STD_LOGIC_VECTOR (31 downto 0);
    signal k0_data : STD_LOGIC_VECTOR(31 downto 0);
    signal k1_data : STD_LOGIC_VECTOR(31 downto 0);
    signal k0_tag_valid_out : STD_LOGIC_VECTOR(4 downto 0);
    signal k1_tag_valid_out : STD_LOGIC_VECTOR(4 downto 0);
    signal k0_wren : STD_LOGIC := '0';
    signal k1_wren : STD_LOGIC := '0';
    signal enable : STD_LOGIC := '1';
    signal k : STD_LOGIC := '0';
    signal hit_readable : STD_LOGIC;
    signal w0_valid, w1_valid : STD_LOGIC;
    signal w0_valid_lru : STD_LOGIC;
begin
    --Data array instantiation--
    k0_data_array: data_array port map(clk => clk , wren => k0_wren, address =>
        full_address(5 downto 0), wrdata => wrdata, data => k0_data);
    k1_data_array: data_array port map(clk => clk , wren => k1_wren, address =>
        full_address(5 downto 0), wrdata => wrdata, data => k1_data);

    --Tag valid instantiation--
    k0_tag_valid: tag_valid_array port map(clk => clk, wren => k0_wren,
                                           reset_n => reset_n,validate => validate,invalidate => invalidate,
                                           address => full_address(5 downto 0), wrdata => full_address(9 downto 6),output => k0_tag_valid_out);

    k1_tag_valid: tag_valid_array port map(clk => clk, wren => k1_wren, reset_n => reset_n,validate => validate, invalidate => invalidate,
                                           address => full_address(5 downto 0), wrdata => full_address(9 downto 6),output => k1_tag_valid_out);

    --Miss hit instantiation--
    miss_hit: miss_hit_logic port map(tag => full_address(9 downto 6),w0 => k0_tag_valid_out
    ,w1 => k1_tag_valid_out,hit => hit_readable,w0_valid => w0_valid,w1_valid => w1_valid);

    hit <= hit_readable;
    --Lru array instantiation--
    lru_logic: lru_array port map(address => full_address(5 downto 0),k => k,
                                  clk => clk,reset=> invalidate,w0_valid => w0_valid_lru, enable => enable);

    mux_2 : mux port map(k, k0_data, k1_data, data);


    process(clk)
        variable current : integer := 0;
        constant begin_write : integer := 1;
        constant begin_read : integer := 2;
        constant start : integer := 0;
        variable one_loop : integer := 0;
        variable address_to_be_written: STD_LOGIC_VECTOR(9 downto 0);
        variable last_address : STD_LOGIC_VECTOR(9 downto 0);
        variable last_write : STD_LOGIC;
        variable last_wrdata : STD_LOGIC_VECTOR(31 downto 0);
    begin
        if(current = start) then
            if(last_address /= full_address or last_write /= wren or wrdata /= last_wrdata) then
                if(wren = '1') then
                    current := begin_write;
                    k0_wren <= '0';
                    k1_wren <= '0';
                    cache_ready <= '0';
                    enable <= '0';
                    address_to_be_written := full_address;
                else
                    current := start;
                    k1_wren <= '0';
                    k <= w1_valid;
                    if(one_loop = 1) then
                        k0_wren <= '0';
                    end if;

                end if;
            else
                k <= w1_valid;
                k0_wren <= '0';
                k1_wren <= '0';
                enable <= '0';
            end if;
        elsif(current = begin_write) then
            if(address_to_be_written = full_address) then
                current := start;
                k0_wren <= (not hit_readable and w0_valid_lru and wren) or (hit_readable and w0_valid and wren);
                k1_wren <= ((not w0_valid_lru) and wren and not hit_readable) or (hit_readable and w1_valid and wren);
                k <= (not hit_readable and w0_valid_lru and wren) or (hit_readable and w0_valid and wren);
                enable <= '1';
                one_loop := 1;
                cache_ready <= '1';
            else
                one_loop := 1;
                current := start;
            end if;
        end if;
        last_address := full_address;
        last_wrdata := wrdata;
        last_write := wren;
    end process;
end gate_level;
