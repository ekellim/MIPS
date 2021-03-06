----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/06/2020 02:05:35 PM
-- Design Name: 
-- Module Name: Control - Behavioral
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

entity Control is
    Port ( 
        clk         : in STD_LOGIC;
        opcode      : in STD_LOGIC_VECTOR(5 DOWNTO 0);
        RegDst      : out STD_LOGIC;
        Jump        : out STD_LOGIC;
        Branch      : out STD_LOGIC;
        MemRead     : out STD_LOGIC;
        MemtoReg    : out STD_LOGIC;
        ALUOp       : out STD_LOGIC_VECTOR(1 DOWNTO 0);
        MemWrite    : out STD_LOGIC;
        ALUSrc      : out STD_LOGIC;
        RegWrite    : out STD_LOGIC
    );
end Control;

architecture Behavioral of Control is

begin

    controlProcess:process(clk)
    begin
        case opcode is
            when "000000" =>        --R-instruction
                RegDst      <= '1';
                Jump        <= '0';
                Branch      <= '0';
                MemRead     <= '0';
                MemtoReg    <= '0';
                ALUOp       <= "10";
                MemWrite    <= '0';
                ALUSrc      <= '0';
                RegWrite    <= '1';
            when "001000" =>        --addi
                RegDst      <= '0';
                Jump        <= '0';
                Branch      <= '0';
                MemRead     <= '0';
                MemtoReg    <= '0';
                ALUOp       <= "00";
                MemWrite    <= '0';
                ALUSrc      <= '1';
                RegWrite    <= '1';     
             when others  =>
                RegDst      <= '0';
                Jump        <= '0';
                Branch      <= '0';
                MemRead     <= '0';
                MemtoReg    <= '0';
                ALUOp       <= "00";
                MemWrite    <= '0';
                ALUSrc      <= '0';
                RegWrite    <= '0';                          
                 
         end case;

    end process;


end Behavioral;
