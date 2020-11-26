----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2020 12:47:51 PM
-- Design Name: 
-- Module Name: Top_InstructionFetch - Behavioral
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

entity Top_InstructionFetch is
     Port ( 
        clk         : in    STD_LOGIC;
        reset       : in    STD_LOGIC;
        instruction : out STD_LOGIC_VECTOR(31 downto 0)
     );
end Top_InstructionFetch;

architecture Behavioral of Top_InstructionFetch is

    component Top_ProgramCounter is 
        Port(
            clk     : in    STD_LOGIC;
            reset   : in    STD_LOGIC;
            PC      : out   STD_LOGIC_VECTOR(31 downto 0) := (others => '0')
        );
    end component;
    
    component InstructionMemory is 
        Port(
            clk         : in    STD_LOGIC;
            PC          : in    STD_LOGIC_VECTOR(31 downto 0);
            instruction : out   STD_LOGIC_VECTOR(31 downto 0) := (others => '0')
        );
     end component;
     
     signal PC      : STD_LOGIC_VECTOR(31 DOWNTO 0);

begin

    topProgramCounter:Top_ProgramCounter
    port map(
        clk     =>  clk, 
        reset   =>  reset, 
        PC      =>  PC
    );
    
    instruction_memory:InstructionMemory
    port map(
        clk     =>  clk, 
        PC      =>  PC, 
        instruction => instruction
    );


end Behavioral;
