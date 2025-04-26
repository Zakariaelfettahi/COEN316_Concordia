library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity next_address is
    port (
        pc          : in  std_logic_vector(31 downto 0);
        imm_ext     : in  std_logic_vector(31 downto 0);
        instr       : in  std_logic_vector(31 downto 0);
        zero        : in  std_logic;
        branch_type : in  std_logic_vector(1 downto 0);
        pc_sel      : in  std_logic_vector(1 downto 0);
        pc_next     : out std_logic_vector(31 downto 0)
    );
end next_address;

architecture beh of next_address is
begin
    process (pc, imm_ext, instr, zero, branch_type, pc_sel)
    begin
        case pc_sel is
            when "00" =>
                -- PC + 1 (normal execution)
                pc_next <= std_logic_vector(unsigned(pc) + 1);

            when "01" =>
                -- Branches (beq, bne, bltz)
                if (branch_type = "01" and zero = '1') or
                   (branch_type = "10" and zero = '0') or
                   (branch_type = "11" and imm_ext(31) = '1') then
                    pc_next <= std_logic_vector(unsigned(pc) + 1 + unsigned(imm_ext));
                else
                    pc_next <= std_logic_vector(unsigned(pc) + 1);
                end if;

            when "10" =>
                -- Jump Register (jr)
                pc_next <= instr;

            when "11" =>
                -- Jump (j)
                pc_next <= pc(31 downto 28) & instr(25 downto 2); -- Concatenate upper PC and target address, discard 2 bits

            when others =>
                pc_next <= pc;
        end case;
    end process;
end beh;
