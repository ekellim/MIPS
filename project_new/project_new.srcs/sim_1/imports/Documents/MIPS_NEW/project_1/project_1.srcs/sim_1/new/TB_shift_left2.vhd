----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/24/2020 03:02:31 PM
-- Design Name: 
-- Module Name: TB_shift_left2 - Behavioral
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

entity TB_shift_left2 is
--  Port ( );
end TB_shift_left2;

architecture Behavioral of TB_shift_left2 is

    component Shift_left2
        Generic (
            bitwidth :   INTEGER
        );
        Port (
            input   : in    STD_LOGIC_VECTOR(bitwidth-1 DOWNTO 0);
            output  : out   STD_LOGIC_VECTOR(bitwidth-1 DOWNTO 0);
            sign    : in    STD_LOGIC   --signed if 0, unsigned if 1
         );
    end component;
    
    signal input    : STD_LOGIC_VECTOR(31 DOWNTO 0);
    Signal output   : STD_LOGIC_VECTOR(31 DOWNTO 0);
    Signal sign     : STD_LOGIC;

begin

    uut: Shift_left2
    Generic map(
        bitwidth => 32
        )
    port map(
        input, 
        output, 
        sign
    );
    
    sim_process : process
               begin
                   sign <= '0';
                   input <= "10000000000000000000000000000011";
                   wait for 20ns;
                   sign <= '1';
                   wait for 20ns;
                   input <= x"00001235";
                   wait;
               end process;


end Behavioral;
