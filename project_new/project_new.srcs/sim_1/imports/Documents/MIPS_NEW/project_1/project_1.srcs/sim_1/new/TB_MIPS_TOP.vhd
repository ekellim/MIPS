----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/25/2020 03:55:16 PM
-- Design Name: 
-- Module Name: TB_MIPS_TOP - Behavioral
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

entity TB_MIPS_TOP is
--  Port ( );
end TB_MIPS_TOP;

architecture Behavioral of TB_MIPS_TOP is

    component Top_MIPS is
        Port ( 
            clk         :   inout STD_LOGIC;
            clk_uart    :   inout STD_LOGIC;
            reset       :   in STD_LOGIC;
            instr_test  :   out STD_LOGIC_VECTOR(31 DOWNTO 0);   --visualisation in TB and debugging
            data_out    :   out STD_LOGIC_VECTOR(31 DOWNTO 0);
            pc_test     :   out STD_LOGIC_VECTOR(31 DOWNTO 0);
            data_read_1 :   out STD_LOGIC_VECTOR(31 DOWNTO 0);
            data_read_2 :   out STD_LOGIC_VECTOR(31 DOWNTO 0);
            RX          :   in  STD_LOGIC;  
            TX          :   out STD_LOGIC;
            busy_test   : inout STD_LOGIC         
        );
    end component;
    
    signal clk          :   STD_LOGIC := '0';
    signal clk_uart     :   STD_LOGIC := '0';
    signal reset        :   STD_LOGIC := '0';
    signal instr_test   :   STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal data_out     :   STD_LOGIC_VECTOR(31 DOWNTO 0);  
    signal pc_test      :   STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal data_read_1  :   STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal data_read_2  :   STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal RX           :   STD_LOGIC;  
    signal TX           :   STD_LOGIC;       
    signal busy_test    :   STD_LOGIC;   
    
    constant clk_period : time := 10 ns;
    constant baud_period: time := 52083ns;

begin

    uut:Top_MIPS
    port map(
        clk,
        clk_uart,
        reset, 
        instr_test, 
        data_out, 
        pc_test, 
        data_read_1, 
        data_read_2, 
        RX, 
        TX, 
        busy_test
    );
            

    sim_process : process
            begin
                RX <= '1';
               wait for 1000ns;
               RX <= '0';
               wait for baud_period;
               
               RX <= '1';
               wait for baud_period;
               RX <= '0';
              wait for baud_period;
              RX <= '0';
              wait for baud_period;
              RX <= '0';
              wait for baud_period;
              RX <= '0';
              wait for baud_period;
              RX <= '0';
              wait for baud_period;
              RX <= '1';
              wait for baud_period;
              RX <= '0';
              wait for baud_period;
              RX <= '1';
              wait for baud_period;
              RX <= '0';
              wait for baud_period;
              RX <= '0';
              wait for baud_period;
              RX <= '0';
              wait for baud_period;
              RX <= '0';
              wait for baud_period;
              RX <= '0';
              wait for baud_period;
              RX <= '1';
              wait for baud_period;
              RX <= '0';
              wait for baud_period;
              RX <= '1';
              wait for baud_period;
              RX <= '0';
              wait for baud_period;
              RX <= '0';
              wait for baud_period;
              RX <= '0';
              wait for baud_period;
              RX <= '0';
              wait for baud_period;
              RX <= '0';
              wait for baud_period;
              RX <= '1';
              wait for baud_period;
              RX <= '0';
              wait for baud_period;
              RX <= '1';
              wait for baud_period;
              RX <= '0';
              wait for baud_period;
              RX <= '0';
              wait for baud_period;
              RX <= '0';
              wait for baud_period;
              RX <= '0';
              wait for baud_period;
              RX <= '0';
              wait for baud_period;
              RX <= '1';
              wait for baud_period;
              RX <= '0';
              wait for baud_period;
              
              RX <= '1';
                wait for baud_period * 2;
                wait for 8000ns;
                --reset <= '1';
                wait for 1ns;
                reset <= '0';
                wait; 
            end process;



end Behavioral;
