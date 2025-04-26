library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alu_unit is
    port (
        x          : in  std_logic_vector(31 downto 0);
        y          : in  std_logic_vector(31 downto 0);
        add_sub    : in  std_logic;
        logic_func : in  std_logic_vector(1 downto 0);
        func       : in  std_logic_vector(1 downto 0);
        output     : out std_logic_vector(31 downto 0);
        overflow   : out std_logic;
        zero       : out std_logic
    );
end alu_unit;

architecture beh of alu_unit is
    signal addsub_out : std_logic_vector(31 downto 0);
    signal logic_out  : std_logic_vector(31 downto 0);
begin

    -- Add/Subtract Process
    process (x, y, add_sub)
    begin
        if add_sub = '0' then
            addsub_out <= std_logic_vector(signed(x) + signed(y));
        else
            addsub_out <= std_logic_vector(signed(x) - signed(y));
        end if;
    end process;

    -- Logic Operations Process
    process (x, y, logic_func)
    begin
        case logic_func is
            when "00" =>
                logic_out <= x and y;
            when "01" =>
                logic_out <= x or y;
            when "10" =>
                logic_out <= not (x or y); -- NOR
            when others =>
                logic_out <= x xor y;
        end case;
    end process;

    -- ALU Main Operation Select
    process (addsub_out, logic_out, y, func)
    begin
        case func is
            when "00" =>
                output <= y;  -- Pass Y
            when "01" =>
                output <= (31 downto 1 => '0') & addsub_out(31);  -- SLT (set less than)
            when "10" =>
                output <= addsub_out; -- Add/Sub Result
            when others =>
                output <= logic_out; -- Logic Result
        end case;
    end process;

    -- Zero Detection
    process (addsub_out)
    begin
        if addsub_out = (others => '0') then
            zero <= '1';
        else
            zero <= '0';
        end if;
    end process;

    -- Overflow Detection
    process (x, y, add_sub, addsub_out)
    begin
        if add_sub = '0' then -- Addition
            if (x(31) = '0' and y(31) = '0' and addsub_out(31) = '1') or
               (x(31) = '1' and y(31) = '1' and addsub_out(31) = '0') then
                overflow <= '1';
            else
                overflow <= '0';
            end if;
        else -- Subtraction
            if (x(31) = '0' and y(31) = '1' and addsub_out(31) = '1') or
               (x(31) = '1' and y(31) = '0' and addsub_out(31) = '0') then
                overflow <= '1';
            else
                overflow <= '0';
            end if;
        end if;
    end process;

end beh;
