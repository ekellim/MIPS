----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/17/2020 02:17:39 PM
-- Design Name: 
-- Module Name: TB_ALU_Control - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_ALU_Control is
--  Port ( );
end TB_ALU_Control;

architecture Behavioral of TB_ALU_Control is

    component ALU_Control
    Port (
        clk         : in STD_LOGIC;
        ALUOp       : in STD_LOGIC_VECTOR(1 DOWNTO 0);
        func        : in STD_LOGIC_VECTOR (5 DOWNTO 0);
        ALU_Contr   : out STD_LOGIC_VECTOR(3 DOWNTO 0)        
    );
    end component;
    
        signal clk         : STD_LOGIC;
        signal ALUOp       : STD_LOGIC_VECTOR(1 DOWNTO 0);
        signal func        : STD_LOGIC_VECTOR (5 DOWNTO 0);
        signal ALU_Contr   : STD_LOGIC_VECTOR(3 DOWNTO 0);
  
        constant clk_period : time := 10 ns;
begin

    uut:ALU_Control
    port map(
        clk, 
        ALUOp,
        func, 
        ALU_Contr
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
            wait for 20ns;
            ALUOp <= "00";
            wait for 10ns;
            ALUOp <= "01";
            wait for 10ns;
            ALUOp <= "10";
            wait for 10ns;
            func <= "100000";
            wait for 10ns;
            func <= "100010";
            wait for 10ns;
            func <= "100100";
            wait for 10ns;
            func <= "100101";
            wait for 10ns;
            func <= "101010";
            wait;
            end process;
end Behavioral;
