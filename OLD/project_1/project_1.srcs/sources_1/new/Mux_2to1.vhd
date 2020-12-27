----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/14/2020 03:20:05 PM
-- Design Name: 
-- Module Name: Mux_2to1 - Behavioral
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

entity Mux_2to1 is
    Generic(
        N : INTEGER
    );
    Port ( 
        clk         : in    STD_LOGIC;
        selection   : in    STD_LOGIC;
        in_0        : in    STD_LOGIC_VECTOR(N-1 DOWNTO 0);
        in_1        : in    STD_LOGIC_VECTOR(N-1 DOWNTO 0);
        output      : out   STD_LOGIC_VECTOR(N-1 DOWNTO 0)
    );
end Mux_2to1;

architecture Behavioral of Mux_2to1 is

begin

    mux_process:process(clk)
    begin
        case selection is
            when '0' =>
                output <= in_0;
            when '1' =>
                output <= in_1;
            when others =>
                output <= x"00000000";
        end case;
    end process;

end Behavioral;
