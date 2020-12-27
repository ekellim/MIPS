----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/16/2020 02:42:17 PM
-- Design Name: 
-- Module Name: TB_ALU - Behavioral
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

entity TB_ALU is
--  Port ( );
end TB_ALU;

architecture Behavioral of TB_ALU is

    component ALU
        Port(
            clk                 : in STD_LOGIC;
            input_0             : in STD_LOGIC_VECTOR(31 DOWNTO 0);
            input_1             : in STD_LOGIC_VECTOR(31 DOWNTO 0);
            alu_control_in      : in STD_LOGIC_VECTOR(3 DOWNTO 0);
            zero                : out STD_LOGIC;
            overflow            : out STD_LOGIC;
            ALU_res             : out STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    end component;
    
    signal clk                 : STD_LOGIC;
    signal input_0             : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal input_1             : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal alu_control_in      : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal zero                : STD_LOGIC;
    signal overflow            : STD_LOGIC; 
    signal ALU_res             : STD_LOGIC_VECTOR(31 DOWNTO 0);
    
    constant clk_period : time := 10 ns;

begin

    uut:ALU
    port map(
        clk, 
        input_0, 
        input_1, 
        alu_control_in, 
        zero, 
        overflow,
        ALU_res
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
                input_0 <= x"00000002";
                input_1 <= x"f0000001";--input_1 <= x"00000001";
                alu_control_in <= "0010";
                wait for 10ns;
                alu_control_in <= "0000";
                wait for 10ns;
                alu_control_in <= "0001";
                wait for 10ns;
                alu_control_in <= "0110";
                wait for 10ns;
                alu_control_in <= "0111";    
                wait for 10ns;
                alu_control_in <= "1100";          
                wait;
                
            end process;


end Behavioral;
