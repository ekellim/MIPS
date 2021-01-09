----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/08/2021 03:56:15 PM
-- Design Name: 
-- Module Name: Clock_generator - Behavioral
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

entity Clock_generator is
  Port ( 
    disable :   in  STD_LOGIC;
    clk     :   out STD_LOGIC
  );
end Clock_generator;

architecture Behavioral of Clock_generator is
    constant clk_period : time := 10 ns;
begin

    clk_process : process
            begin
                if (disable = '1') then
                    clk <= '0';
                    wait for clk_period;
                else
                    clk <= '1';           
                    wait for clk_period/2;
                    clk <= '0';           
                    wait for clk_period/2;
                end if;    
            end process;

end Behavioral;
