library IEEE;
use IEEE.std_logic_1164.all;

entity i_cache is
    port (
        addr  : in  std_logic_vector(4 downto 0);
        instr : out std_logic_vector(31 downto 0)
    );
end i_cache;

architecture beh of i_cache is
begin
    process (addr)
    begin
        case addr is
            when "00000" =>
                instr <= x"20010001"; -- addi r1, r0, 1
            when "00001" =>
                instr <= x"20020002"; -- addi r2, r0, 2
            when "00010" =>
                instr <= x"00410820"; -- add r2, r2, r1
            when others =>
                instr <= (others => '0'); -- NOP or empty instruction
        end case;
    end process;
end beh;
