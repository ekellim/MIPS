----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/14/2020 03:26:57 AM
-- Design Name: 
-- Module Name: TB_Control - Behavioral
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

entity TB_Control is
--  Port ( );
end TB_Control;

architecture Behavioral of TB_Control is

    component Control is 
        port(
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
    end component;
    
    signal clk : STD_LOGIC :='0';
    signal opcode : STD_LOGIC_VECTOR(5 DOWNTO 0) :="000000";
    signal RegDst : STD_LOGIC :='0';
    signal Jump : STD_LOGIC :='0';
    signal Branch : STD_LOGIC :='0';
    signal MemRead : STD_LOGIC :='0';
    signal MemtoReg : STD_LOGIC :='0';
    signal ALUOp : STD_LOGIC_VECTOR(1 DOWNTO 0):="00";
    signal MemWrite : STD_LOGIC :='0';
    signal ALUSrc : STD_LOGIC :='0';                                                            
    signal RegWrite : STD_LOGIC :='0';
    
    constant clk_period : time := 10 ns;

begin
    uut:Control
        port map(
            clk, 
            opcode, 
            RegDst, 
            Jump, 
            Branch, 
            MemRead, 
            MemtoReg, 
            ALUOp, 
            MemWrite, 
            ALUSrc, 
            RegWrite
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
                    opcode <= "001000";
                    wait for 50ns;
                    opcode <= "000000";
                    wait for 50ns;
                    opcode <= "111111";
                    wait;
                end process;           
                
end Behavioral;
