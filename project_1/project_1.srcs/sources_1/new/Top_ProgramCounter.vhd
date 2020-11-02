library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

----------------------------------------------------------------------------------
entity Top_ProgramCounter is
Port (
    clk     : in    STD_LOGIC;
    reset   : in    STD_LOGIC;
    PC      : out   STD_LOGIC_VECTOR(31 downto 0) := (others => '0')
    );
end Top_ProgramCounter;

----------------------------------------------------------------------------------
architecture Behavioral of Top_ProgramCounter is

    -- Declaratie van de blokjes
    component ProgramCounter is
        Port ( clk      : in    STD_LOGIC;
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
        output      : out       STD_LOGIC_VECTOR(31 downto 0) := (others => '0')
    );
    end component;
    
    -- Signalen voor blokjes te verbinden
    signal PC_old   : STD_LOGIC_VECTOR(31 downto 0);
    signal PC_new   : STD_LOGIC_VECTOR(31 downto 0);
    
----------------------------------------------------------------------------------
begin
    program_counter: ProgramCounter
    port map(
        clk     => clk,
        reset   => reset,
        pc_in   => PC_new,
        pc_out  => pc_old
    );
    
    pcAdder: Adder
    port map(
        clk     => clk,
        input1  => pc_old,
        --input2  => x"00000004",
        input2 => std_logic_vector(to_unsigned(4,32)),
        output  => pc_new
    );
    
    PC <= PC_old;
end Behavioral;
