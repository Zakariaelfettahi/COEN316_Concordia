-- datapath.vhd - COEN 316 Lab 4 - Zakaria El Fettahi

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity datapath is
    Port (
        clk         : in std_logic;
        reset       : in std_logic;
        reg_write   : in std_logic;
        reg_dst     : in std_logic;
        alu_src     : in std_logic;
        mem_to_reg  : in std_logic;
        mem_write   : in std_logic;
        ext_op      : in std_logic_vector(1 downto 0);
        alu_op      : in std_logic_vector(1 downto 0)
    );
end datapath;

architecture Structural of datapath is
    -- Signals for instruction fields
    signal instruction      : std_logic_vector(31 downto 0);
    signal rs, rt, rd       : std_logic_vector(4 downto 0);
    signal imm16            : std_logic_vector(15 downto 0);
    
    -- Signals between components
    signal reg_out_a, reg_out_b : std_logic_vector(31 downto 0);
    signal alu_result           : std_logic_vector(31 downto 0);
    signal dmem_out             : std_logic_vector(31 downto 0);
    signal write_data           : std_logic_vector(31 downto 0);
    signal alu_input_b          : std_logic_vector(31 downto 0);
    signal sign_extended        : std_logic_vector(31 downto 0);
    signal write_reg_addr       : std_logic_vector(4 downto 0);
    signal pc, next_pc          : std_logic_vector(31 downto 0);

begin
    -- Program Counter (PC) register
    process(clk, reset)
    begin
        if reset = '1' then
            pc <= (others => '0');
        elsif rising_edge(clk) then
            pc <= next_pc;
        end if;
    end process;

    -- Instruction Cache (ROM)
    inst_rom: entity work.instruction_cache port map (
        addr => pc(4 downto 0),
        inst => instruction
    );

    rs    <= instruction(25 downto 21);
    rt    <= instruction(20 downto 16);
    rd    <= instruction(15 downto 11);
    imm16 <= instruction(15 downto 0);

    -- Register File
    regfile_inst: entity work.regfile port map (
        clk     => clk,
        reset   => reset,
        read_a  => rs,
        read_b  => rt,
        write_a => write_reg_addr,
        d_in    => write_data,
        write   => reg_write,
        out_a   => reg_out_a,
        out_b   => reg_out_b
    );

    -- Sign Extender
    signext_inst: entity work.sign_extender port map (
        imm_in  => imm16,
        imm_out => sign_extended
    );

    -- ALU Input MUX
    alu_input_b <= reg_out_b when alu_src = '0' else sign_extended;

    -- ALU
    alu_inst: entity work.alu port map (
        x_in        => reg_out_a,
        y_in        => alu_input_b,
        alu_op      => alu_op,
        output_out  => alu_result
    );

    -- Data Cache (RAM)
    dmem: entity work.data_cache port map (
        clk      => clk,
        reset    => reset,
        addr     => alu_result(4 downto 0),
        d_in     => reg_out_b,
        write_en => mem_write,
        d_out    => dmem_out
    );

    -- MUX for memory or ALU result
    write_data <= dmem_out when mem_to_reg = '1' else alu_result;

    -- Write register address selection
    write_reg_addr <= rt when reg_dst = '0' else rd;

    -- Next Address Logic (assume increment by 1 for now)
    next_pc <= std_logic_vector(unsigned(pc) + 1);

end Structural;
