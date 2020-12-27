----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2020 01:05:20 PM
-- Design Name: 
-- Module Name: TB_Top_InstructionFetch - Behavioral
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

entity TB_Top_InstructionFetch is
--  Port ( );
end TB_Top_InstructionFetch;

architecture Behavioral of TB_Top_InstructionFetch is

    component Top_InstructionFetch is
        port(
            clk         : in    STD_LOGIC;
            reset       : in    STD_LOGIC;
            instruction : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;
    
    signal clk      : STD_LOGIC := '0';
    signal reset    : STD_LOGIC := '0';
    signal instruction : STD_LOGIC_VECTOR(31 DOWNTO 0) := (others =>'0');
    
    constant clk_period : time := 10 ns;
    
begin

    uut:Top_InstructionFetch
    port map(
        clk,
        reset, 
        instruction
    );
    
    clk_process : process
            begin
                clk <= '1';
                wait for clk_period/2;
                clk <= '0';
                wait for clk_period/2;
            end process;

    test_process : process
        begin
            wait for 500ns;
            reset <= '1';
            wait for 1ns;
            reset <= '0';
            wait;
        end process;
        
end Behavioral;
