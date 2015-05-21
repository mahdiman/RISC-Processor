library ieee;
use ieee.std_logic_1164.all;

entity execute is
	port(ra, rb, rp : in std_logic_vector(1 downto 0);
        op1, op2, pipeline, pc : in std_logic_vector(7 downto 0);
        fa, fb, pc_in, pc_dirty, is_pipe_dirty, save_flags, restore_flags : in std_logic;
        old_flags : in std_logic_vector(3 downto 0);
        mode : in std_logic_vector(5 downto 0);
        br_mode: in std_logic_vector(3 downto 0);
        in_condition : in std_logic_vector(1 downto 0);
        sel_dst, cin, mem, wr, change_flag, get_flags : in std_logic;
        fetch_reg_file : in std_logic_vector(7 downto 0);
        get_from_fetch1, get_from_fetch2 : in std_logic;
        result1, result2, addr: out std_logic_vector(7 downto 0);
        rout1, rout2 : out std_logic_vector(1 downto 0);
        out_condition : out std_logic_vector(1 downto 0);
        out_flags: out std_logic_vector(3 downto 0);
        mem_access, write_back, select_result, flush, pc_read, pipeline_dirty, save_flags_out, restore_flags_out : out std_logic
    );
end execute;

architecture execute_arch of execute is

    --+--------------+-----+--------+
    --|    alu_mode  | cin | F	    |
    --+--------------+-----+--------+
    --|     0        |  0  | A      |
    --|     0        |  1  | A+1    |
    --|     1        |  0  | A+B    |
    --|     1        |  1  | A+B+1  |
    --|     2        |  0  | A-B-1  |
    --|     2        |  1  | A-B    |
    --|     3        |  0  | A-1    |
    --|     3        |  1  | NEG A  |
    --+--------------+-----+--------+
    --|     4        |  -  | A & B  |
    --|     5        |  -  | A | B  |
    --|     6        |  -  | A ^ B  |
    --|     7        |  -  | NOT A  |
    --+--------------+-----+--------+
    --|     8        |  -  | LSR    |
    --|     9        |  -  | RR     |
    --|     10       |  -  | RRC    |
    --|     11       |  -  | ASR    |
    --+--------------+-----+--------+
    --|     12       |  -  | LSL    | 
    --|     13       |  -  | RL     |
    --|     14       |  -  | RLC    |
    --|     15       |  -  | ASL    |
    --+--------------+-----+--------+

	component Alu is  
        generic (n : integer := 8);
        port (a : in std_logic_vector (n-1 downto 0);
            b : in std_logic_vector (n-1 downto 0);
            old_flags : in std_logic_vector(3 downto 0);
            alu_mode : in std_logic_vector(3 downto 0);
            cin : in std_logic;
            result : out std_logic_vector (n-1 downto 0);
            alu_flags : out std_logic_vector(3 downto 0) );    
	end component;
    component branch_component is 
        port(
            pc_branch_value, ra: in std_logic_vector (7 downto 0);
            mode, flags: in std_logic_vector(3 downto 0);
            pc_pre : in std_logic_vector(7 downto 0);       
            pc_next : out std_logic_vector(7 downto 0);
            flush: out std_logic);
    end component;

    signal v1, v2 : std_logic_vector(7 downto 0);
    signal sel1, sel2 : std_logic_vector(1 downto 0);
    signal s1, s2 : std_logic;

    signal alu_mode : std_logic_vector(3 downto 0);
    signal alu_flags : std_logic_vector(3 downto 0);
    signal alu_result : std_logic_vector(7 downto 0);
    signal pc_next : std_logic_vector(7 downto 0);

begin

    -- select alu mode
    alu_mode <= mode(3 downto 0);

    -- mem access
    mem_access <= mem;

    -- write back
    write_back <= wr;

    -- forward ra if in pipline
    sel1 <= ra xor rp;
    s1 <= sel1(1) or sel1(0);
    v1 <= fetch_reg_file when get_from_fetch1 = '1' 
    else ("0000" & old_flags) when get_flags = '1'
    else op1 when (s1 = '1' or fa = '0' or is_pipe_dirty = '0') else pipeline;

    -- forward rb if in pipline
    sel2 <= rb xor rp;
    s2 <= sel2(1) OR sel2(0);
    v2 <= fetch_reg_file when get_from_fetch2 = '1' 
    else op2 when (s2 = '1' or fb = '0' or pc_in = '1' or is_pipe_dirty = '0') else pipeline;
 
    -- get flags
    out_flags <= old_flags when change_flag = '0'
    else alu_result(3 downto 0) when mode = "110101" or mode = "110100"
    else alu_flags;

    -- alu
   	u0: Alu generic map(8) port map(v1, v2, old_flags, alu_mode , cin, alu_result , alu_flags);

    -- branch component 
    u1: branch_component port map(v2, v1, br_mode, old_flags, pc, pc_next, flush);
 
    -- get destination register
    rout1 <= rb when (sel_dst = '1') else ra; 
    rout2 <= rb when mode = "110011" or mode = "110000" -- push|pop
    else "00";

   -- get result
    result1 <= alu_result;
    result2 <= pc_next when mode(5 downto 4) = "10"
    else op2 when mode = "110011" or mode = "110000" -- push|pop
    else (others => '0');

    -- select from result1 and result2
    select_result <= '1' when mode = "110011" or mode = "110000" -- push|pop
    else '0';

    -- get address
    addr <= v2 when mode (5 downto 4) = "01"
    else v1 when mode = "110011"
    else alu_result when mode = "110000"
    else (others => '0');

    out_condition <= in_condition;
    pc_read <= pc_in;
    pipeline_dirty <= pc_dirty;
    save_flags_out <= save_flags;
    restore_flags_out <= restore_flags;

end execute_arch;