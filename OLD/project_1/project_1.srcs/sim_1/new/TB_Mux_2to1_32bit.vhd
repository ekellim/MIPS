----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/14/2020 05:28:24 AM
-- Design Name: 
-- Module Name: TB_Mux_2to1_32bit - Behavioral
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

entity TB_Mux_2to1_32bit is
--  Port ( );
end TB_Mux_2to1_32bit;

architecture Behavioral of TB_Mux_2to1_32bit is

    component Mux_2to1
      Generic (N : INTEGER);
      Port ( 
      clk         : in    STD_LOGIC;
      selection   : in    STD_LOGIC;
      in_0        : in    STD_LOGIC_VECTOR(N-1 DOWNTO 0);
      in_1        : in    STD_LOGIC_VECTOR(N-1 DOWNTO 0);
      output      : out   STD_LOGIC_VECTOR(N-1 DOWNTO 0)
    );
    end component;
    
    signal clk      : STD_LOGIC :='0';
    signal selection: STD_LOGIC :='0';
    signal in_0     : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal in_1     : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal output   : STD_LOGIC_VECTOR(31 DOWNTO 0);
    
    constant clk_period : time := 10 ns;
begin


    uut: Mux_2to1
    generic map (N => 32)
    port map(
        clk, 
        selection, 
        in_0, 
        in_1, 
        output
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
               in_0 <= x"12345678";
               in_1 <= x"02466420";
               wait for 50ns;
               selection <= '1';
               wait for 50ns;
               selection <= '0';
               wait;
           end process;

end Behavioral;
