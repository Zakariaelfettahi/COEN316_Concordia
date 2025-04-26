-- control_unit.vhd - COEN 316 Lab 4 - Zakaria El Fettahi

library IEEE;
use IEEE.std_logic_1164.all;

entity control_unit is
    port (
        opcode        : in  std_logic_vector(5 downto 0);
        funct         : in  std_logic_vector(5 downto 0);
        reg_write     : out std_logic;
        reg_dst       : out std_logic;
        reg_in_src    : out std_logic;
        alu_src       : out std_logic;
        add_sub       : out std_logic;
        data_write    : out std_logic;
        logic_func    : out std_logic_vector(1 downto 0);
        ext_func      : out std_logic_vector(1 downto 0);
        branch_type   : out std_logic_vector(1 downto 0);
        pc_sel        : out std_logic_vector(1 downto 0)
    );
end control_unit;

architecture beh of control_unit is
begin
    process (opcode, funct)
    begin
        -- Default values
        reg_write   <= '0';
        reg_dst     <= '0';
        reg_in_src  <= '0';
        alu_src     <= '0';
        add_sub     <= '0';
        data_write  <= '0';
        logic_func  <= "00";
        ext_func    <= "11";
        branch_type <= "00";
        pc_sel      <= "00";

        case opcode is
            -- R-type instructions
            when "000000" =>
                reg_write <= '1';
                case funct is
                    when "100000" => -- ADD
                        add_sub <= '0';
                    when "100010" => -- SUB
                        add_sub <= '1';
                    when "101010" => -- SLT
                        add_sub <= '1';
                    when "100100" => -- AND
                        logic_func <= "00";
                    when "100101" => -- OR
                        logic_func <= "01";
                    when "100110" => -- XOR
                        logic_func <= "10";
                    when "100111" => -- NOR
                        logic_func <= "11";
                    when "001000" => -- JR
                        pc_sel <= "10";
                    when others =>
                        null;
                end case;

            -- Immediate instructions
            when "001111" => -- LUI
                reg_write    <= '1';
                reg_dst      <= '0';
                alu_src      <= '1';
                reg_in_src   <= '1';
                ext_func     <= "00";

            when "001000" => -- ADDI
                reg_write    <= '1';
                reg_dst      <= '0';
                alu_src      <= '1';
                reg_in_src   <= '0';
                add_sub      <= '0';
                ext_func     <= "01";

            when "001010" => -- SLTI
                reg_write    <= '1';
                reg_dst      <= '0';
                alu_src      <= '1';
                reg_in_src   <= '0';
                add_sub      <= '1';
                ext_func     <= "01";

            when "001100" => -- ANDI
                reg_write    <= '1';
                reg_dst      <= '0';
                alu_src      <= '1';
                reg_in_src   <= '0';
                logic_func   <= "00";
                ext_func     <= "11";

            when "001101" => -- ORI
                reg_write    <= '1';
                reg_dst      <= '0';
                alu_src      <= '1';
                reg_in_src   <= '0';
                logic_func   <= "01";
                ext_func     <= "11";

            when "001110" => -- XORI
                reg_write    <= '1';
                reg_dst      <= '0';
                alu_src      <= '1';
                reg_in_src   <= '0';
                logic_func   <= "10";
                ext_func     <= "11";

            -- Load/Store
            when "100011" => -- LW
                reg_write    <= '1';
                reg_dst      <= '0';
                alu_src      <= '1';
                reg_in_src   <= '1';
                ext_func     <= "01";

            when "101011" => -- SW
                data_write   <= '1';
                alu_src      <= '1';
                ext_func     <= "01";

            -- Branches
            when "000100" => -- BEQ
                branch_type  <= "01";
                pc_sel       <= "01";

            when "000101" => -- BNE
                branch_type  <= "10";
                pc_sel       <= "01";

            when "000001" => -- BLTZ
                branch_type  <= "11";
                pc_sel       <= "01";

            -- Jump
            when "000010" => -- J
                pc_sel       <= "11";

            when others =>
                null;
        end case;
    end process;
end beh;
