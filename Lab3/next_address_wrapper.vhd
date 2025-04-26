library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity next_address is
    port (
        rt_in, rs_in      : in std_logic_vector(1 downto 0);
        pc_in             : in std_logic_vector(2 downto 0);
        target_address_in : in std_logic_vector(2 downto 0);
        branch_type       : in std_logic_vector(1 downto 0);
        pc_sel            : in std_logic_vector(1 downto 0);
        next_pc_out       : out std_logic_vector(2 downto 0)
    );
end next_address;

architecture board of next_address is
begin
    process(pc_in, pc_sel, branch_type, rt_in, rs_in, target_address_in)
        variable pc_val : unsigned(2 downto 0);
        variable offset : signed(2 downto 0);
        variable rs_signed : signed(1 downto 0);
    begin
        pc_val := unsigned(pc_in);
        rs_signed := signed(rs_in);

        -- Crude 2-bit sign extension (for bltz)
        if target_address_in(2) = '0' then
            offset := signed("0" & target_address_in(1 downto 0));
        else
            offset := signed("1" & target_address_in(1 downto 0));
        end if;

        case pc_sel is
            when "00" =>  -- Normal + branching
                case branch_type is
                    when "00" =>  -- No branch
                        next_pc_out <= std_logic_vector(pc_val + 1);
                    when "01" =>  -- BEQ
                        if rs_in = rt_in then
                            next_pc_out <= std_logic_vector(pc_val + 1 + unsigned(offset));
                        else
                            next_pc_out <= std_logic_vector(pc_val + 1);
                        end if;
                    when "10" =>  -- BNE
                        if rs_in /= rt_in then
                            next_pc_out <= std_logic_vector(pc_val + 1 + unsigned(offset));
                        else
                            next_pc_out <= std_logic_vector(pc_val + 1);
                        end if;
                    when "11" =>  -- BLTZ
                        if rs_signed(1) = '1' then
                            next_pc_out <= std_logic_vector(pc_val + 1 + unsigned(offset));
                        else
                            next_pc_out <= std_logic_vector(pc_val + 1);
                        end if;
                    when others =>
                        next_pc_out <= std_logic_vector(pc_val + 1);
                end case;

            when "01" =>  -- Jump
                next_pc_out <= target_address_in;

            when "10" =>  -- Jump Register (JR)
                next_pc_out <= rs_in;

            when others =>
                next_pc_out <= std_logic_vector(pc_val + 1);
        end case;
    end process;
end board;
