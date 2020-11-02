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
    0=>x"0000000", -- nop
    1=>"00100000000000100000000000000011", -- R[2] = R[0] + 3 (addi $v0 $zero 0x003
    2=>x"0000007",
    3=>"00000000001000100001100000100000", -- R[3] = R[1] + R[2]
    127 => "0000000",
    others => (others => '0')
    );
begin
    instructionMemoryProcess:process(clk)
    begin
        memory(to_integer(unsigned(PC))) <= x"1234567";
    
        instruction <= memory(to_integer(unsigned(PC)));
    end process;
end Behavioral;
