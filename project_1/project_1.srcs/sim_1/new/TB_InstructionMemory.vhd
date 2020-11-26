----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2020 03:32:29 AM
-- Design Name: 
-- Module Name: TB_InstructionMemory - Behavioral
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

entity TB_InstructionMemory is
--  Port ( );
end TB_InstructionMemory;

architecture Behavioral of TB_InstructionMemory is
    component InstructionMemory is
    Port (
        clk         : in    STD_LOGIC;
        PC          : in    STD_LOGIC_VECTOR(31 downto 0);
        instruction : out   STD_LOGIC_VECTOR(31 downto 0) := (others => '0')
        );
    end component;
    
        -- Input signalen
        signal clk      : STD_LOGIC := '0';
        signal PC       : STD_LOGIC_VECTOR(31 downto 0);
        -- Output signalen
        signal instruction       : STD_LOGIC_VECTOR(31 downto 0);
        
        -- Constanten
        constant clk_period : time := 10 ns;
    
begin

    uut:InstructionMemory
    port map(
    clk     => clk, 
    PC      => PC, 
    instruction => instruction
    );
    
    clk_process : process
        begin
            clk <= '1';
            wait for clk_period/2;
            clk <= '0';
            wait for clk_period/2;
        end process;
    
    sim_process : process
        begin
            wait for 100ns;
            PC <= STD_LOGIC_VECTOR(to_unsigned(0, 32));
            wait for 10ns;
            PC <= STD_LOGIC_VECTOR(to_unsigned(2, 32));
            wait for 10ns;
            PC <= STD_LOGIC_VECTOR(to_unsigned(4, 32));
            wait;
        end process;
end Behavioral;
