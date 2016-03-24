library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cache is
    port(clk, wren, reset_n :in STD_LOGIC;
         full_address :in STD_LOGIC_VECTOR(9 downto 0);
         wrdata :in STD_LOGIC_VECTOR(31 downto 0);
         validity :in STD_LOGIC;
         data: out STD_LOGIC_VECTOR(31 downto 0);
         hit: in STD_LOGIC
     );
end cache;

architecture gate_level of cache is
    type data_array_data is array (63 downto 0) of STD_LOGIC_VECTOR (31 downto 0);
    signal k0_data : data_array_data;
    signal k1_data : data_array_data;
    signal k0_wren : STD_LOGIC;
    signal k1_wren : STD_LOGIC;
begin
    k0_data_array: data_array port map(clk => clk,k0_wren => wren,
                                       wrdata => wrdata, k0_data => data);
end gate_level;
