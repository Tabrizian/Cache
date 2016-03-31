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
    end component;

    signal wr_cache : STD_LOGIC;
    signal wr_ram : STD_LOGIC;
    signal invalidate : STD_LOGIC;
    signal validate : STD_LOGIC;
begin
    cache_instance : cache port map(clk, wr_cache, reset_n, addr,
end dataflow;
