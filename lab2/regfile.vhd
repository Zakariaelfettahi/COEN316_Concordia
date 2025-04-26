library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity register_file is
    port (
        din           : in  std_logic_vector(31 downto 0);
        reset         : in  std_logic;
        clk           : in  std_logic;
        write         : in  std_logic;
        read_a        : in  std_logic_vector(4 downto 0);
        read_b        : in  std_logic_vector(4 downto 0);
        write_address : in  std_logic_vector(4 downto 0);
        out_a         : out std_logic_vector(31 downto 0);
        out_b         : out std_logic_vector(31 downto 0)
    );
end register_file;

architecture beh of register_file is
    type reg_array is array (0 to 31) of std_logic_vector(31 downto 0);
    signal registers : reg_array := (others => (others => '0'));
begin
    process (reset, clk)
    begin
        if reset = '1' then
            registers <= (others => (others => '0'));
        elsif rising_edge(clk) then
            if write = '1' then
                registers(conv_integer(write_address)) <= din;
            end if;
        end if;
    end process;

    out_a <= registers(conv_integer(read_a));
    out_b <= registers(conv_integer(read_b));
end beh;
