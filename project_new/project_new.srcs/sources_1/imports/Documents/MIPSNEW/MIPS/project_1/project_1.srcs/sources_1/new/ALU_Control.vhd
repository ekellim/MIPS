----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/17/2020 01:54:12 PM
-- Design Name: 
-- Module Name: ALU_Control - Behavioral
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

entity ALU_Control is
  Port ( 
    clk         : in STD_LOGIC;
    ALUOp       : in STD_LOGIC_VECTOR(2 DOWNTO 0);
    func        : in STD_LOGIC_VECTOR (5 DOWNTO 0);
    Usigned     : out STD_LOGIC;
    ALU_Contr   : out STD_LOGIC_VECTOR(3 DOWNTO 0)
  );
end ALU_Control;

architecture Behavioral of ALU_Control is

begin

    ALU_Control_process:process(ALUOp, func)
    begin
        case ALUOp is
            when "000" =>
                ALU_Contr <= "0010";    --add(i)
                Usigned <= '0';
            when "001" =>
                ALU_Contr <= "0010";    --addiu
                Usigned <= '1';
            when "011" =>
                ALU_Contr <= "0111";     --slti
                Usigned <= '0';
            when "101" =>
                ALU_Contr <= "0111";     --sltiu
                Usigned <= '1';
            when "010" =>
                ALU_Contr <= "0110";    --subtract
            when "111" =>
                ALU_Contr <= "0001";     --ori
            when "100" =>
                case func is
                    when "100000" =>            --add
                        ALU_Contr <= "0010";
                        Usigned <= '0';
                    when "100001" =>            --addu
                        ALU_Contr <= "0010";
                        Usigned <= '1';
                    when "100010" =>            --subtract
                        ALU_Contr <= "0110";
                        Usigned <= '0';
                    when "100011" =>            --subtract unsigned
                        ALU_Contr <= "0110";
                        Usigned <= '1';
                    when "100100" =>            --AND
                        ALU_Contr <= "0000";
                        Usigned <= '0';
                    when "100101" =>            --OR    
                        ALU_Contr <= "0001";
                        Usigned <= '0';
                    when "100111" =>            --NOR
                        ALU_Contr <= "0011";
                        Usigned <= '0';
                    when "101010" =>            --set on less than
                        ALU_Contr <= "0111";
                        Usigned <= '0';
                    when "101011" =>            --set on less than unsigned
                        ALU_Contr <= "0111";
                        Usigned <= '1';
                    when "000000" =>            --shift left logical
                        ALU_Contr <= "0100";
                        Usigned <= '0';
                    when "000010" =>            --shift right logical
                        ALU_Contr <= "0101";
                        Usigned <= '0';
                    when "011010" =>            --div
                        ALU_Contr <= "1001";
                        Usigned <= '0';
                    when "011000" =>            --mult
                        ALU_Contr <= "1010";
                        Usigned <= '0';
                    when "010010" =>            --mflo
                        ALU_Contr <= "1011";
                        Usigned <= '0';
                    when "010000" =>            --mfhi
                        ALU_Contr <= "1100";  
                        Usigned <= '0';
                    when others =>
                        ALU_Contr <= "1111";
                end case;
            when "110" =>
                ALU_Contr <= "1101";            --bne
                Usigned <= '0';
            when others =>
                ALU_Contr <= "1111";
        end case;
    end process;

end Behavioral;
