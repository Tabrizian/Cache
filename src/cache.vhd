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
    component data_array is
        port(clk, wren:in STD_LOGIC;
             address:in STD_LOGIC_VECTOR(5 downto 0);
             wrdata:in STD_LOGIC_VECTOR(31 downto 0);
             data:out STD_LOGIC_VECTOR(31 downto 0)
         );
    end component;

        type data_array_data is array (63 downto 0) of STD_LOGIC_VECTOR (31 downto 0);
        signal k0_data : STD_LOGIC_VECTOR(31 downto 0);
        signal k1_data : STD_LOGIC_VECTOR(31 downto 0);
        signal k0_wren : STD_LOGIC;
        signal k1_wren : STD_LOGIC;
begin
    k0_data_array: data_array port map(clk ,k0_wren ,full_address(5 downto 0),wrdata , k0_data);
    k1_data_array: data_array port map(clk ,k1_wren ,full_address(5 downto 0),wrdata , k1_data);
end gate_level;
