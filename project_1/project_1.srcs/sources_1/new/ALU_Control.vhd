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
    ALUOp       : in STD_LOGIC_VECTOR(1 DOWNTO 0);
    func        : in STD_LOGIC_VECTOR (5 DOWNTO 0);
    ALU_Contr   : out STD_LOGIC_VECTOR(3 DOWNTO 0)
  );
end ALU_Control;

architecture Behavioral of ALU_Control is

begin

    ALU_Control_process:process(clk)
    begin
        case ALUOp is
            when "00" =>
                ALU_Contr <= "0010";
            when "01" =>
                ALU_Contr <= "0110";
            when "10" =>
                case func is
                    when "100000" =>
                        ALU_Contr <= "0010";
                    when "100010" =>
                        ALU_Contr <= "0110";
                    when "100100" =>
                        ALU_Contr <= "0000";
                    when "100101" =>
                        ALU_Contr <= "0001";
                    when "101010" =>
                        ALU_Contr <= "0111";
                    when others =>
                        ALU_Contr <= "1111";
                end case;
            when others =>
                ALU_Contr <= "1111";
        end case;
    end process;

end Behavioral;
