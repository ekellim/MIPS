----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/24/2020 07:38:51 AM
-- Design Name: 
-- Module Name: Shift_left2 - Behavioral
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

entity Shift_left2 is
    Generic (
        bitwidth :   INTEGER
    );
    Port (
        input   : in    STD_LOGIC_VECTOR(bitwidth-1 DOWNTO 0);
        output  : out   STD_LOGIC_VECTOR(bitwidth-1 DOWNTO 0);
        sign    : in    STD_LOGIC   --signed if 0, unsigned if 1
     );
end Shift_left2;

architecture Behavioral of Shift_left2 is

begin

    shift_process:process(input, sign)
    begin
        if(sign='0') then
                output <= std_logic_vector(shift_left(signed(input), 2));
            else
                output <= std_logic_vector(shift_left(unsigned(input), 2));
        end if;
    end process;


end Behavioral;
