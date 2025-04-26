-- cpu.vhd - COEN 316 Lab 4 - Zakaria El Fettahi

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cpu is
    port (
        reset    : in std_logic;
        clk      : in std_logic;
        rs_out   : out std_logic_vector(3 downto 0);
        rt_out   : out std_logic_vector(3 downto 0);
        pc_out   : out std_logic_vector(3 downto 0);
        overflow : out std_logic;
        zero     : out std_logic
    );
end cpu;

architecture beh of cpu is
    -- Internal signals
    signal pc_sig, pc_next   : std_logic_vector(31 downto 0);
    signal instr             : std_logic_vector(31 downto 0);
    signal rs, rt            : std_logic_vector(4 downto 0);
    signal rd_addr           : std_logic_vector(4 downto 0);
    signal reg_out_a, reg_out_b : std_logic_vector(31 downto 0);
    signal imm_ext           : std_logic_vector(31 downto 0);
    signal alu_input_b       : std_logic_vector(31 downto 0);
    signal alu_result        : std_logic_vector(31 downto 0);
    signal mem_data          : std_logic_vector(31 downto 0);
    signal write_data        : std_logic_vector(31 downto 0);
    signal pc_low5           : std_logic_vector(4 downto 0);

    -- Control signals
    signal reg_write, reg_in_src, reg_dst, alu_src, add_sub, data_write : std_logic;
    signal logic_func, ext_func, branch_type, pc_sel : std_logic_vector(1 downto 0);
    signal zero_sig : std_logic;

    -- Components
    component pc
        port (
            clk     : in  std_logic;
            reset   : in  std_logic;
            pc_in   : in  std_logic_vector(31 downto 0);
            pc_out  : out std_logic_vector(31 downto 0)
        );
    end component;

    component i_cache
        port (
            addr  : in  std_logic_vector(4 downto 0);
            instr : out std_logic_vector(31 downto 0)
        );
    end component;

    component control_unit
        port (
            opcode       : in  std_logic_vector(5 downto 0);
            funct        : in  std_logic_vector(5 downto 0);
            reg_write    : out std_logic;
            reg_dst      : out std_logic;
            reg_in_src   : out std_logic;
            alu_src      : out std_logic;
            add_sub      : out std_logic;
            data_write   : out std_logic;
            logic_func   : out std_logic_vector(1 downto 0);
            ext_func     : out std_logic_vector(1 downto 0);
            branch_type  : out std_logic_vector(1 downto 0);
            pc_sel       : out std_logic_vector(1 downto 0)
        );
    end component;

    component register_file
        port (
            din            : in  std_logic_vector(31 downto 0);
            reset          : in  std_logic;
            clk            : in  std_logic;
            write          : in  std_logic;
            read_a         : in  std_logic_vector(4 downto 0);
            read_b         : in  std_logic_vector(4 downto 0);
            write_address  : in  std_logic_vector(4 downto 0);
            out_a          : out std_logic_vector(31 downto 0);
            out_b          : out std_logic_vector(31 downto 0)
        );
    end component;

    component sign_extender
        port (
            imm_in   : in  std_logic_vector(15 downto 0);
            ext_func : in  std_logic_vector(1 downto 0);
            imm_out  : out std_logic_vector(31 downto 0)
        );
    end component;

    component alu_unit
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
    end component;

    component d_cache
        port (
            clk         : in  std_logic;
            reset       : in  std_logic;
            addr        : in  std_logic_vector(4 downto 0);
            write_data  : in  std_logic_vector(31 downto 0);
            we          : in  std_logic;
            read_data   : out std_logic_vector(31 downto 0)
        );
    end component;

    component next_address
        port (
            pc           : in  std_logic_vector(31 downto 0);
            imm_ext      : in  std_logic_vector(31 downto 0);
            instr        : in  std_logic_vector(31 downto 0);
            zero         : in  std_logic;
            branch_type  : in  std_logic_vector(1 downto 0);
            pc_sel       : in  std_logic_vector(1 downto 0);
            pc_next      : out std_logic_vector(31 downto 0)
        );
    end component;

begin

    -- PC Update
    pc_inst: pc
        port map (clk => clk, reset => reset, pc_in => pc_next, pc_out => pc_sig);

    pc_low5 <= pc_sig(4 downto 0);
    pc_out  <= pc_sig(3 downto 0);

    -- Instruction Fetch
    icache_inst: i_cache
        port map (addr => pc_low5, instr => instr);

    -- Control Unit
    control_inst: control_unit
        port map (
            opcode      => instr(31 downto 26),
            funct       => instr(5 downto 0),
            reg_write   => reg_write,
            reg_dst     => reg_dst,
            reg_in_src  => reg_in_src,
            alu_src     => alu_src,
            add_sub     => add_sub,
            data_write  => data_write,
            logic_func  => logic_func,
            ext_func    => ext_func,
            branch_type => branch_type,
            pc_sel      => pc_sel
        );

    -- Register Read
    rs <= instr(25 downto 21);
    rt <= instr(20 downto 16);

    regfile_inst: register_file
        port map (
            din            => write_data,
            reset          => reset,
            clk            => clk,
            write          => reg_write,
            read_a         => rs,
            read_b         => rt,
            write_address  => rd_addr,
            out_a          => reg_out_a,
            out_b          => reg_out_b
        );

    rs_out <= reg_out_a(3 downto 0);

    rd_addr <= instr(15 downto 11) when reg_dst = '1' else instr(20 downto 16);

    -- Immediate Extension
    sign_extender_inst: sign_extender
        port map (
            imm_in   => instr(15 downto 0),
            ext_func => ext_func,
            imm_out  => imm_ext
        );

    -- ALU Inputs
    alu_input_b <= imm_ext when alu_src = '1' else reg_out_b;

    -- ALU
    alu_inst: alu_unit
        port map (
            x          => reg_out_a,
            y          => alu_input_b,
            add_sub    => add_sub,
            logic_func => logic_func,
            func       => "10",  -- Perform ALU Main Operation
            output     => alu_result,
            overflow   => overflow,
            zero       => zero_sig
        );

    -- Data Cache
    dcache_inst: d_cache
        port map (
            clk         => clk,
            reset       => reset,
            addr        => alu_result(4 downto 0),
            write_data  => reg_out_b,
            we          => data_write,
            read_data   => mem_data
        );

    rt_out <= mem_data(3 downto 0);

    -- Write Back Data Selection
    write_data <= alu_result when reg_in_src = '0' else mem_data;

    -- PC Next Calculation
    next_pc: next_address
        port map (
            pc           => pc_sig,
            imm_ext      => imm_ext,
            instr        => reg_out_a,
            zero         => zero_sig,
            branch_type  => branch_type,
            pc_sel       => pc_sel,
            pc_next      => pc_next
        );

    -- Zero Flag
    zero <= zero_sig;

end beh;
