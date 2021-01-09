----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/25/2020 03:31:23 AM
-- Design Name: 
-- Module Name: Top_MIPS - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Top_MIPS is
    Port ( 
        clk         :   inout STD_LOGIC;    --voor visualisatie
        clk_uart    :   inout STD_LOGIC;    --voor visualisatie
        reset       :   in STD_LOGIC;
        instr_test  :   out STD_LOGIC_VECTOR(31 DOWNTO 0);   --visualisation in TB and debugging
        data_out    :   out STD_LOGIC_VECTOR(31 DOWNTO 0);
        pc_test     :   out STD_LOGIC_VECTOR(31 DOWNTO 0);
        data_read_1 :   out STD_LOGIC_VECTOR(31 DOWNTO 0);
        data_read_2 :   out STD_LOGIC_VECTOR(31 DOWNTO 0);
        RX          :   in  STD_LOGIC;
        TX          :   out STD_LOGIC;
        busy_test   :   inout STD_LOGIC
    );
end Top_MIPS;

architecture Behavioral of Top_MIPS is

    component ProgramCounter is
        Port ( 
               clk      : in    STD_LOGIC;
               reset    : in    STD_LOGIC;
               pc_in    : in    STD_LOGIC_VECTOR (31 downto 0);
               pc_out   : out   STD_LOGIC_VECTOR (31 downto 0) := (others => '0')
               );
    end component;      
    
    component Adder is
        Port (
                clk         : in        STD_LOGIC;
                input1      : in        STD_LOGIC_VECTOR(31 downto 0);
                input2      : in        STD_LOGIC_VECTOR(31 downto 0);
                output      : out       STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
                reset       : in        STD_LOGIC
                );
    end component;

    component InstructionMemory is 
            Port(
                clk         : in    STD_LOGIC;
                PC          : in    STD_LOGIC_VECTOR(31 downto 0);
                instruction : out   STD_LOGIC_VECTOR(31 downto 0) := (others => '0')
            );
    end component;
    
    component Sign_extend
            Generic(
                bitwidth_in     :   INTEGER;
                bitwidth_out    :   INTEGER
            );
            Port(
                input   : in    STD_LOGIC_VECTOR(bitwidth_in-1 DOWNTO 0);
                output  : out   STD_LOGIC_VECTOR(bitwidth_out-1 DOWNTO 0);
                sign    : in    STD_LOGIC   --signed if 0, unsigned if 1
            );
     end component;
     
    component Shift_left2
             Generic (
                 bitwidth :   INTEGER
             );
             Port (
                 input   : in    STD_LOGIC_VECTOR(bitwidth-1 DOWNTO 0);
                 output  : out   STD_LOGIC_VECTOR(bitwidth-1 DOWNTO 0);
                 sign    : in    STD_LOGIC   --signed if 0, unsigned if 1
              );
    end component;
    
    component Mux_2to1
          Generic (N : INTEGER);
          Port ( 
              clk         : in    STD_LOGIC;
              selection   : in    STD_LOGIC;
              in_0        : in    STD_LOGIC_VECTOR(N-1 DOWNTO 0);
              in_1        : in    STD_LOGIC_VECTOR(N-1 DOWNTO 0);
              output      : out   STD_LOGIC_VECTOR(N-1 DOWNTO 0)
            );
     end component;
     
    component Control is 
             port(
                     clk         : in STD_LOGIC;
                     opcode      : in STD_LOGIC_VECTOR(5 DOWNTO 0);
                     RegDst      : out STD_LOGIC;
                     Jump        : out STD_LOGIC;
                     Branch      : out STD_LOGIC;
                     MemRead     : out STD_LOGIC;
                     MemtoReg    : out STD_LOGIC;
                     ALUOp       : out STD_LOGIC_VECTOR(2 DOWNTO 0);
                     MemWrite    : out STD_LOGIC;
                     ALUSrc      : out STD_LOGIC;
                     RegWrite    : out STD_LOGIC
             );
    end component;
    
    component Registers is
                port(
                    clk     : in STD_LOGIC;
                    reset   : in STD_LOGIC := '0';        
                    reg_write  : in STD_LOGIC := '0';
                    read_reg_1 : in STD_LOGIC_VECTOR (4 DOWNTO 0) := (others => '0');
                    read_reg_2 : in STD_LOGIC_VECTOR (4 DOWNTO 0) := (others => '0');
                    write_reg  : in STD_LOGIC_VECTOR (4 DOWNTO 0) := (others => '0');
                    write_data : in STD_LOGIC_VECTOR (31 DOWNTO 0) := (others => '0');     
                    read_data_1: out STD_LOGIC_VECTOR (31 DOWNTO 0) := (others => '0');
                    read_data_2: out STD_LOGIC_VECTOR (31 DOWNTO 0) := (others => '0') 
                );
    end component;
    
   component ALU_Control
        Port (
                clk         : in STD_LOGIC;
                ALUOp       : in STD_LOGIC_VECTOR(2 DOWNTO 0);
                func        : in STD_LOGIC_VECTOR (5 DOWNTO 0);
                Usigned     : out STD_LOGIC;
                ALU_Contr   : out STD_LOGIC_VECTOR(3 DOWNTO 0)        
        );
    end component; 
    
    component ALU
            Port(
                clk                 : in STD_LOGIC;
                input_0             : in STD_LOGIC_VECTOR(31 DOWNTO 0);
                input_1             : in STD_LOGIC_VECTOR(31 DOWNTO 0);
                alu_control_in      : in STD_LOGIC_VECTOR(3 DOWNTO 0);
                shamt               : in STD_LOGIC_VECTOR(4 DOWNTO 0);
                Usigned             : in STD_LOGIC;
                zero                : out STD_LOGIC;
                overflow            : out STD_LOGIC;
                ALU_res             : out STD_LOGIC_VECTOR(31 DOWNTO 0)
            );
    end component;
    
    component dataMemory is
        Port ( 
        clk         : in STD_LOGIC;                                           
        reset       : in STD_LOGIC;                                           
        address     : in STD_LOGIC_VECTOR (31 downto 0);                      
        writeData   : in STD_LOGIC_VECTOR (31 downto 0);                      
        memRead     : in STD_LOGIC;                                           
        memWrite    : in STD_LOGIC;                                           
        readData    : out STD_LOGIC_VECTOR (31 downto 0) := (others => '0');  
        uartSend    : out STD_LOGIC_VECTOR (31 downto 0) := (others => '0');  
        startSend   : out STD_LOGIC;                                          
        uartReceive : in  STD_LOGIC_VECTOR (31 downto 0) := (others => '0');  
        received    : in  STD_LOGIC := '0'                                    
        );
    end component;
    
    component AND_gate is
      Port ( 
        input1  :   in  STD_LOGIC;
        input2  :   in  STD_LOGIC;
        output  :   out STD_LOGIC       
      );
    end component;
    
    component Clock_generator is
        Port (
        disable     : in STD_LOGIC;
        clk         : out STD_LOGIC
        );
    end component;
    
    component UART is
        Generic(                    
        baud_rate: NATURAL:= 9600
        );                           
        Port (
        clk_i:       in         std_logic;                    
        data_i:      in         std_logic_vector(31 downto 0);
        start_tx_i:  in         std_logic;                    
                                                              
        data_o:      out        std_logic_vector(31 downto 0);
        rx_received: out        std_logic;                    
                                                              
        RX_i:        in         std_logic;                    
        TX_o:        out        std_logic;                    
                                                              
        busy:        out        std_logic                     
        );
     end component;
    
    --signal clk          :   STD_LOGIC; 
    --signal clk_uart     :   STD_LOGIC;
    
    signal data_send    : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal data_received: STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal start_tx     : STD_LOGIC;
    signal rx_received  : STD_LOGIC;
    signal uart_busy    : STD_LOGIC;
    
    signal pc_in        :   STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal pc_out       :   STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal pc_plus_4    :   STD_LOGIC_VECTOR(31 DOWNTO 0);
    
    signal sign_extend_instr_25to0 : STD_LOGIC_VECTOR(27 DOWNTO 0);
    signal jump_address :   STD_LOGIC_VECTOR(31 DOWNTO 0);
    
    signal instruction  :   STD_LOGIC_VECTOR(31 DOWNTO 0);
    
    signal RegDst       : STD_LOGIC;
    signal Jump         : STD_LOGIC;
    signal Branch       : STD_LOGIC;
    signal MemRead      : STD_LOGIC;
    signal MemtoReg     : STD_LOGIC;
    signal ALUOp        : STD_LOGIC_VECTOR(2 DOWNTO 0);
    signal MemWrite     : STD_LOGIC;
    signal ALUSrc       : STD_LOGIC;                                                            
    signal RegWrite     : STD_LOGIC;
    signal Usigned      : STD_LOGIC;
    
    signal write_reg    : STD_LOGIC_VECTOR(4 DOWNTO 0);
    signal write_data   : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal read_data_1  : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal read_data_2  : STD_LOGIC_VECTOR(31 DOWNTO 0);
    
    signal mux_ALU_input: STD_LOGIC_VECTOR(31 DOWNTO 0);
    
    signal sign_extend_instr_15to0  : STD_LOGIC_VECTOR(31 DOWNTO 0);        --immediate
    signal shl_se_instr_15to0       : STD_LOGIC_VECTOR(31 DOWNTO 0);        
    
    signal new_pc_plus_imm : STD_LOGIC_VECTOR(31 DOWNTO 0);
    
    signal zero         : STD_LOGIC;
    signal overflow     : STD_LOGIC;
    signal ALU_result   : STD_LOGIC_VECTOR(31 DOWNTO 0);
    
    signal ALU_contr    : STD_LOGIC_VECTOR(3 DOWNTO 0);
    
    signal branch_and_zero : STD_LOGIC;
    
    signal read_data_dm : STD_LOGIC_VECTOR(31 DOWNTO 0);
    
    signal branch_mux   : STD_LOGIC_VECTOR(31 DOWNTO 0);
    
    signal jump_mux    : STD_LOGIC_VECTOR(31 DOWNTO 0);
    
    constant clk_period : time := 10 ns;
begin

    pc:ProgramCounter
    port map(
        clk     => clk,
        reset   => reset, 
        pc_in   => pc_in, 
        pc_out  => pc_out        
    );
    
    pcAdder:Adder
    port map(
        clk     => clk, 
        reset   => reset,
        input1  => pc_out, 
        input2  => std_logic_vector(to_unsigned(4,32)), 
        output  => pc_plus_4
        --output(31 DOWNTO 28) => jump_address(31 DOWNTO 28)
    );
    
    instrMemory:instructionMemory
    port map(
        clk     => clk,
        pc      => pc_out, 
        instruction => instruction
    );
    
    control_block:Control
    port map(
        clk     => clk,        
        opcode  => instruction(31 DOWNTO 26),
        RegDst  => RegDst, 
        Jump    => Jump, 
        Branch  => Branch,
        MemRead => MemRead,
        MemtoReg    => MemtoReg,
        ALUOp       => ALUOp,
        MemWrite    => MemWrite,
        ALUSrc      => ALUSrc,
        RegWrite    => RegWrite
    );
    
    mux_write_reg:Mux_2to1
    generic map(
        N => 5
    )
    port map(
        clk         => clk, 
        selection   => RegDst, 
        in_0        => instruction(20 DOWNTO 16),
        in_1        => instruction(15 DOWNTO 11),
        output      => write_reg
    );

    mips_registers:Registers
    port map(
        clk         => clk, 
        reset       => reset, 
        reg_write   => RegWrite, 
        read_reg_1  => instruction(25 DOWNTO 21), 
        read_reg_2  => instruction(20 DOWNTO 16), 
        write_reg   => write_reg, 
        write_data  => write_data , 
        read_data_1 => read_data_1, 
        read_data_2 => read_data_2
    );
    
    imm_sign_extend:Sign_extend
    generic map(
        bitwidth_in     => 16, 
        bitwidth_out    => 32
    )
    port map(
        input       => instruction(15 DOWNTO 0), 
        output      => sign_extend_instr_15to0, 
        sign        => '0'
    );
    
    imm_shl:Shift_left2
    generic map(
            bitwidth    => 32 
    )
    port map(
            input       => sign_extend_instr_15to0, 
            output      => shl_se_instr_15to0, 
            sign        => '0'
    );
    
    addr_sign_extend:Sign_extend
    generic map(
        bitwidth_in     => 26, 
        bitwidth_out    => 28
    )
    port map(
        input       => instruction(25 DOWNTO 0), 
        output      => sign_extend_instr_25to0, 
        sign        => '0'
    );
    
    addr_shl:Shift_left2
    generic map(
            bitwidth    => 28 
    )
    port map(
            input       => sign_extend_instr_25to0, 
            output      => jump_address(27 DOWNTO 0), 
            sign        => '0'
    );  
   
   ALUControl:ALU_Control
   port map(
        clk         => clk, 
        aluop       => ALUOp, 
        func        => instruction(5 DOWNTO 0), 
        Usigned     => Usigned,
        ALU_Contr   => ALU_Contr      
   );
   
   main_alu:ALU
   port map(
        clk         => clk, 
        input_0     => read_data_1, 
        input_1     => mux_ALU_input,
        shamt       => instruction(10 DOWNTO 6),
        alu_control_in => ALU_Contr,
        Usigned     => Usigned,
        zero        => zero, 
        overflow    => overflow,
        ALU_res     => ALU_result
   );
   
   mux_alu_in:Mux_2to1
   generic map(
        N => 32
   )
   port map(
        clk         => clk, 
        selection   => ALUSrc, 
        in_0        => read_data_2, 
        in_1        => sign_extend_instr_15to0, 
        output      => mux_ALU_input
   );
   
   and_gate_branch_and_zero:And_gate
   port map(
        input1      => branch, 
        input2      => zero, 
        output      => branch_and_zero
   );
   
   adder_alu_res:Adder
   port map(
        clk         => clk, 
        reset       => reset, 
        input1      => pc_plus_4, 
        input2      => shl_se_instr_15to0,
        output      => new_pc_plus_imm     
   );
   
   mux_branch:Mux_2to1
   generic map(
        N => 32
   )
   port map(
        clk         => clk, 
        selection   => branch_and_zero, 
        in_0        => pc_plus_4, 
        in_1        => new_pc_plus_imm, 
        output      => branch_mux
   );
   
   mux_jump:Mux_2to1
   generic map(
        N => 32
   )
   port map(
        clk         => clk, 
        selection   => jump, 
        in_0        => branch_mux, 
        in_1        => jump_address, 
        output      => pc_in
   );
   
   data_memory:dataMemory
   port map(
       clk          => clk, 
       reset        => reset, 
       address      => ALU_result,
       writeData    => read_data_2,
       memRead      => memRead,
       memWrite     => memWrite,
       readData     => read_data_dm, 
       uartSend     => data_send,
       uartReceive  => data_received,
       startSend    => start_tx,
       received     => rx_received
   );
   
   mux_data:Mux_2to1
   generic map(
        N => 32
   )
   port map(
        clk         => clk, 
        selection   => memToReg, 
        in_0        => ALU_result, 
        in_1        => read_data_dm, 
        output      => write_data
   );
       
     uart1:UART
     generic map(
          baud_rate   => 9600
     )
     port map(
          clk_i       => clk_uart,
          data_i      => data_send,  
          data_o      => data_received,
          start_tx_i  => start_tx,
          rx_received => rx_received,
          busy        => busy_test,
          RX_i        => RX,
          TX_o        => TX   
     );
   
       clock_MIPS:Clock_generator
       port map(
            disable     => busy_test,
            clk         => clk
       );
   
    clock_UART:Clock_generator
    port map(
         disable     => '0',
         clk         => clk_uart
    );
   
   
    
    pc_test                     <= pc_out;
    instr_test                  <= instruction;
    data_out                    <= write_data;
    data_read_1                 <= read_data_1;
    data_read_2                 <= read_data_2;
    jump_address(31 DOWNTO 28)  <= pc_plus_4(31 DOWNTO 28);
    
end Behavioral;
