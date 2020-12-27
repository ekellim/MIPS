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
    1=>"00100000000000100000000000000011", -- v0 = zero + 3 (addi $v0 $zero 0x003)
    2=>"00111100000010000000000000000111", -- t0 = 7 (lui t0 0x0007 )
    3=>"00100000010010100000000000000001", -- t2 = v0+1  (addi t2 v0 0x0001)  t2=4
    4=>"00000001010010000101100000100000", -- t3 = t2 + t0 (add t3 t2 t0)     t3=11
    5=>"10101100000010110000000000001000", -- Mem(zero+8)=t3 (sw t3 0x0008 zero) Mem(8)=11
    6=>"10001100000011000000000000001001", -- t4 = Mem(zero+9) (lw t4 0x0009 zero) t4=2
    15=>"00000000001000100001100000100000",-- R[3] = R[1] + R[2]
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
