library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity d_cache is
    port (
        clk         : in  std_logic;
        reset       : in  std_logic;
        addr        : in  std_logic_vector(4 downto 0);
        write_data  : in  std_logic_vector(31 downto 0);
        we          : in  std_logic;
        read_data   : out std_logic_vector(31 downto 0)
    );
end d_cache;

architecture rtl of d_cache is
    type ram_type is array (0 to 31) of std_logic_vector(31 downto 0);
    signal ram : ram_type := (others => (others => '0'));
begin
    -- Write Process
    process (clk, reset)
    begin
        if reset = '1' then
            ram <= (others => (others => '0'));
        elsif rising_edge(clk) then
            if we = '1' then
                ram(to_integer(unsigned(addr))) <= write_data;
            end if;
        end if;
    end process;

    -- Read Port (combinational)
    read_data <= ram(to_integer(unsigned(addr)));

end rtl;
