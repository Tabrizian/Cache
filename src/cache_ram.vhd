library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cache_ram is
    port(reset_n,clk,read,write: in STD_LOGIC;
         addr : in STD_LOGIC_VECTOR(9 downto 0);
         wrdata: in STD_LOGIC_VECTOR(31 downto 0);
         rddata: out STD_LOGIC_VECTOR(31 downto 0);
         hit: out STD_LOGIC
     );
end cache_ram;

architecture dataflow of cache_ram is
    component cache is
        port(clk, wren, reset_n :in STD_LOGIC;
             full_address :in STD_LOGIC_VECTOR(9 downto 0);
             wrdata :in STD_LOGIC_VECTOR(31 downto 0);
             validate : in STD_LOGIC;
             invalidate :in STD_LOGIC;
             data: out STD_LOGIC_VECTOR(31 downto 0);
             hit: out STD_LOGIC;
             cache_ready: out STD_LOGIC := '1'
         );
    end component;

    component ram is
        port(clk, wr:in STD_LOGIC;
             address:in STD_LOGIC_VECTOR(9 downto 0);
             data_in:in STD_LOGIC_VECTOR(31 downto 0);
             data_out:out STD_LOGIC_VECTOR(31 downto 0);
             ram_ready:out STD_LOGIC := '0'
         );
    end component;

    component controller is
        port(write : in STD_LOGIC;
             read : in STD_LOGIC;
             hit : in STD_LOGIC;
             clk : in STD_LOGIC;
             cache_ready: in STD_LOGIC := '0';
             ram_ready : in STD_LOGIC := '0';
             wr_cache: out STD_LOGIC := '0';
             wr_ram: out STD_LOGIC := '0';
             invalidate : out STD_LOGIC := '0';
             validate : out STD_LOGIC := '1'
         );
    end component;

    signal wr_cache : STD_LOGIC;
    signal wr_ram : STD_LOGIC;
    signal invalidate : STD_LOGIC;
    signal validate : STD_LOGIC;
    signal wren : STD_LOGIC := '0';
    signal hit_out : STD_LOGIC;
    signal cache_ready : STD_LOGIC := '1';
    signal ram_out : STD_LOGIC_VECTOR( 31 downto 0);
    signal ram_ready : STD_LOGIC;
    signal cache_out : STD_LOGIC_VECTOR (31 downto 0);
    signal which : STD_LOGIC;

begin
    cache_instance : cache port map(clk, wr_cache, reset_n, addr, ram_out, validate,invalidate,cache_out,hit_out,cache_ready);
    ram_instance : ram port map(clk, wr_ram, addr, wrdata, ram_out, ram_ready);
    controler_instance: controller port map(write, read, hit_out, clk, cache_ready, ram_ready, wr_cache,wr_ram,invalidate,validate);

    which <= read;
    hit <= hit_out;
    rddata <= ram_out when write = '1' else
              cache_out when read = '1' else
              cache_out;

end dataflow;
