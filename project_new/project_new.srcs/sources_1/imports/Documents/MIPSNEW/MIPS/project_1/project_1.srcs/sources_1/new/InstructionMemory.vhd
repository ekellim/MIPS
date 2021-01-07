library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity InstructionMemory is
Port (
    clk         : in    STD_LOGIC;
    PC          : in    STD_LOGIC_VECTOR(31 downto 0);
    instruction : out   STD_LOGIC_VECTOR(31 downto 0) := (others => '0')
    );
end InstructionMemory;

----------------------------------------------------------------------------------
architecture Behavioral of InstructionMemory is
    subtype memoryword_t is STD_LOGIC_VECTOR(31 downto 0);
    type memory_t is array(0 to 127) of memoryword_t;
    
    signal memory:memory_t:=(
    0=> x"00000000", -- nop
    1=>"00100000000000100000000000000011", -- R[2] = R[0] + 3           v0 = zero + 3 (addi $v0 $zero 0x003)
    2=>"00111100000010000000000000000111", -- t0 = 7        (lui t0 0x0007 )
    3=>"00100000010010100000000000000001", -- t2 = v0+1     (addi t2 v0 0x0001) t2=4
    4=>"00000001010010000101100000100000", -- t3 = t2 + t0  (add t3 t2 t0)      t3=11
    5=>"10101100000010110000000000001000", -- Mem(zero+8)=t3    (sw t3 0x0008 zero) Mem(8)=11
    6=>"10001100000011000000000000001001", -- t4 = Mem(zero+9)  (lw t4 0x0009 zero) t4=2
    7=>"00000001011000100110100000100010", -- t5 = t3 - v0  (sub t5 t3 v0)     t5=8
    8=>"00000001101010100111000000100100", -- t6 = t5 & t2  (and t6 t5 t2)     t6=0
    9=>"00000001101010100111000000100101", -- t6 = t5 | t2  (or t6 t5 t2)      t6=12
    10=>"00000001110000100111100000100111", -- t7 = -(t6 | v0)  (nor t7 t6 v0)  t7 = 0xfffffff0
    11=>"00000001011011100111100000101010", -- t7 = (t3 < t6)? 1:0  (slt t7 t3 t6)  t7 = 1
    12=>"00000000000011111100000011000000", -- t8 = t7 << 3  (sll t8 t7 0x0003)   t8 = 8
    13=>"00000000000110001100000010000010", -- t8 = t8 >>> 2  (srl t8 t8 0x0002)   t8 = 2
    14=>"00001000000000000000000000010010", -- PC=18    (j 0x0012)
    15=>"00000001010010111100100000100001", -- t9 = t2 + t3   (addu t9 t2 t3) t9 = 15
    --16=>"00010001100011000000000000000001", -- if(t4 == t4) PC=PC+4+BranchAddr (beq t4 t4 0x0001)   LATEN STAAN
    16=>"00010001100011000000000000000000", -- if(t4 == t4) PC=PC+4+BranchAddr (beq t4 t4 0x0000)
    17=>"00010101100000000000000000000001", -- if(t4 != 0) PC=PC+4+BranchAddr (bne t4 $zero 0x0001)   
    18=>"00001000000000000000000000001111", -- PC=15 (j 0x000f)
    19=>"00000001011011000000000000011010", -- Lo = t3 / t4 , Hi= t3%t2  (div t3 t4)
    20=>"00000000000000000110100000010010", -- t5 = Lo  (mflo t5)   t5 = 5  
    21=>"00000000000000000111000000010000", -- t6 = Hi  (mfhi t6)   t6 = 5
    22=>"00000001010011000000000000011000", -- {Hi,Lo} = t2 * t4    (mult t2 t4)
    23=>"00000000000000000110100000010010", -- t5 = Lo  (mflo t5)   t5 = 8
    24=>"00000000000000000111000000010000", -- t6 = Hi  (mfhi t6)   t6 = 0
    25=>"00100101010010100000000000000001", -- t2 = t2 + 1  (addiu t2 t2 0x0001) t2 = 5
    
   
    
    --15=>"00000000001000100001100000100000",-- R[3] = R[1] + R[2] (add)
    
    127 => x"00000000",
    others => (others => '0')
    );
begin
    instructionMemoryProcess:process(clk)
    begin
        --memory(to_integer(unsigned(PC))) <= x"1234567";
    
        instruction <= memory(to_integer(unsigned(PC(31 downto 2))));
    end process;
end Behavioral;
