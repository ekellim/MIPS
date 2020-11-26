----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/06/2020 07:29:59 AM
-- Design Name: 
-- Module Name: TB_Registers - Behavioral
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

entity TB_Registers is
--  Port ( );
end TB_Registers;

architecture Behavioral of TB_Registers is
    component Registers is
        port(
        clk     : in STD_LOGIC;
        reset   : in STD_LOGIC := '0';        
        reg_write  : in STD_LOGIC := '0';
        read_reg_1 : in STD_LOGIC_VECTOR (4 DOWNTO 0) := (others => '0');
        read_reg_2 : in STD_LOGIC_VECTOR (4 DOWNTO 0) := (others => '0');
        write_reg  : in STD_LOGIC_VECTOR (4 DOWNTO 0) := (others => '0');
        write_data : in STD_LOGIC_VECTOR (31 DOWNTO 0) := (others => '0');     
        read_data_1: out STD_LOGIC_VECTOR (31 DOWNTO 0) := (others => '0');
        read_data_2: out STD_LOGIC_VECTOR (31 DOWNTO 0) := (others => '0') 
        );
    end component;
    
    signal clk : STD_LOGIC;
    signal reset: STD_LOGIC;
    signal reg_write: STD_LOGIC;
    signal read_reg_1 : STD_LOGIC_VECTOR (4 DOWNTO 0);
    signal read_reg_2 : STD_LOGIC_VECTOR (4 DOWNTO 0);
    signal write_reg  : STD_LOGIC_VECTOR (4 DOWNTO 0);
    signal write_data : STD_LOGIC_VECTOR (31 DOWNTO 0);     
    signal read_data_1: STD_LOGIC_VECTOR (31 DOWNTO 0);
    signal read_data_2: STD_LOGIC_VECTOR (31 DOWNTO 0);
    
    constant clk_period : time := 10 ns;
    
begin

    uut:Registers
    port map(
        clk, 
        reset, 
        reg_write, 
        read_reg_1, 
        read_reg_2, 
        write_reg, 
        write_data, 
        read_data_1, 
        read_data_2
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
                    wait for 10ns;
                    read_reg_1 <= std_logic_vector(to_unsigned(4, 5));
                    write_reg <= std_logic_vector(to_unsigned(4, 5));
                    write_data <= x"25002500";
                    reg_write <= '1';
                    wait for 10ns;
                    write_reg <= std_logic_vector(to_unsigned(0, 5));
                    write_data <= x"00000000";
                    reg_write <= '0';
                    wait for 10ns;
                    read_reg_1 <= std_logic_vector(to_unsigned(0, 5));
                    wait for 10ns;
                    read_reg_1 <= std_logic_vector(to_unsigned(4, 5));
                    wait for 20ns;
                    reset <='1';
                    wait for 1ns;
                    reset <='0';
                    wait for 19ns;
                    read_reg_1 <= std_logic_vector(to_unsigned(4, 5));
                    wait for 10ns;
                    read_reg_2 <= std_logic_vector(to_unsigned(0, 5));
                    write_reg <= std_logic_vector(to_unsigned(0, 5));
                    write_data <= x"00005500";
                    reg_write <= '1';
                    wait for 10ns;
                    reg_write <= '0';
                    wait;
                end process;

end Behavioral;
