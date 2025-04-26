library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity regfile_wrapper is
    port (
        clk               : in  std_logic;
        reset             : in  std_logic;
        write             : in  std_logic;
        din_in            : in  std_logic_vector(3 downto 0);
        read_a_in         : in  std_logic_vector(1 downto 0);
        read_b_in         : in  std_logic_vector(1 downto 0);
        write_address_in  : in  std_logic_vector(1 downto 0);
        out_a_out         : out std_logic_vector(3 downto 0);
        out_b_out         : out std_logic_vector(3 downto 0)
    );
end regfile_wrapper;

architecture wrapper_arch of regfile_wrapper is
    signal din_full          : std_logic_vector(31 downto 0) := (others => '0');
    signal out_a_full        : std_logic_vector(31 downto 0);
    signal out_b_full        : std_logic_vector(31 downto 0);
    signal read_a_full       : std_logic_vector(4 downto 0);
    signal read_b_full       : std_logic_vector(4 downto 0);
    signal write_address_full: std_logic_vector(4 downto 0);
begin
    din_full(3 downto 0) <= din_in;

    read_a_full <= "000" & read_a_in;
    read_b_full <= "000" & read_b_in;
    write_address_full <= "000" & write_address_in;

    regfile_inst: entity work.register_file
        port map (
            clk           => clk,
            reset         => reset,
            write         => write,
            din           => din_full,
            read_a        => read_a_full,
            read_b        => read_b_full,
            write_address => write_address_full,
            out_a         => out_a_full,
            out_b         => out_b_full
        );

    out_a_out <= out_a_full(3 downto 0);
    out_b_out <= out_b_full(3 downto 0);
end wrapper_arch;
