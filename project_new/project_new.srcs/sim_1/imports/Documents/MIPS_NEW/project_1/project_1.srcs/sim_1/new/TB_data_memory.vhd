----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/26/2020 03:20:47 PM
-- Design Name: 
-- Module Name: TB_data_memory - Behavioral
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

entity TB_data_memory is
--  Port ( );
end TB_data_memory;

architecture Behavioral of TB_data_memory is

component dataMemory is
    Port ( 
    clk         : in STD_LOGIC;
    reset       : in STD_LOGIC;
    address     : in STD_LOGIC_VECTOR (31 downto 0);
    writeData   : in STD_LOGIC_VECTOR (31 downto 0);
    memRead     : in STD_LOGIC;
    memWrite    : in STD_LOGIC;
    readData    : out STD_LOGIC_VECTOR (31 downto 0) := (others => '0')
    );
end component;

signal clk      : STD_LOGIC;
signal reset    : STD_LOGIC;
signal address  : STD_LOGIC_VECTOR(31 DOWNTO 0);
signal writeData: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal memRead  : STD_LOGIC;
signal memWrite : STD_LOGIC;
signal readData : STD_LOGIC_VECTOR(31 DOWNTO 0);

                                        
constant clk_period : time := 10 ns;

begin

    uut:dataMemory
    port map(
        clk, 
        reset, 
        address, 
        writeData, 
        memRead, 
        memWrite, 
        readData
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
                    address <= std_logic_vector(to_unsigned(4, 32));
                    writeData <= x"01234567";
                    memWrite <= '1';
                    memRead <= '0';
                    wait for 10ns;
                    memWrite <= '0';
                    address <= std_logic_vector(to_unsigned(8, 32));
                    memRead <= '1';
                    wait for 10ns;
                    address <= std_logic_vector(to_unsigned(4, 32));
                    wait;
                end process;
end Behavioral;
