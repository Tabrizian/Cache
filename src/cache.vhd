library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cache is
    port(clk, wren, reset_n :in STD_LOGIC;
         full_address :in STD_LOGIC_VECTOR(9 downto 0);
         wrdata :in STD_LOGIC_VECTOR(31 downto 0);
         validate, invalidate :in STD_LOGIC;
         data: out STD_LOGIC_VECTOR(31 downto 0);
         hit: out STD_LOGIC
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
             update : in STD_LOGIC;
             clk : in STD_LOGIC;
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
    signal k0_wren : STD_LOGIC;
    signal k1_wren : STD_LOGIC;
    signal k : STD_LOGIC;
    signal w0_valid, w1_valid : STD_LOGIC;
    signal w0_valid_lru : STD_LOGIC;
    signal not_wren : STD_LOGIC;
begin
    --Data array instantiation--
    k0_data_array: data_array port map(clk ,k0_wren ,full_address(5 downto 0),wrdata , k0_data);
    k1_data_array: data_array port map(clk ,k1_wren ,full_address(5 downto 0),wrdata , k1_data);

    --Tag valid instantiation--
    k0_tag_valid: tag_valid_array port map(clk, k0_wren, reset_n,validate,invalidate,
    full_address(5 downto 0), full_address(9 downto 6),k0_tag_valid_out);

    k1_tag_valid: tag_valid_array port map(clk, k1_wren, reset_n,validate,invalidate,
    full_address(5 downto 0), full_address(9 downto 6),k1_tag_valid_out);

    --Miss hit instantiation--
    miss_hit: miss_hit_logic port map(full_address(9 downto 6),k0_tag_valid_out
    ,k1_tag_valid_out,w0_valid,w1_valid,hit);

    --Lru array instantiation--
    not_wren <= wren;
    lru_logic: lru_array port map(full_address(5 downto 0),k,not_wren,
    clk,w0_valid_lru);

    k <= (wren and (not w0_valid)) or ((not wren) and (not w0_valid));

    k0_wren <= w0_valid_lru and wren;
    k1_wren <= (not w0_valid_lru) and wren;

    mux_2 : mux port map(k, k0_data, k1_data, data);
end gate_level;
