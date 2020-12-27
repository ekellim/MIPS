----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/24/2020 06:14:34 AM
-- Design Name: 
-- Module Name: Sign_extend - Behavioral
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

entity Sign_extend is
    Generic(
        bitwidth_in     :   INTEGER;
        bitwidth_out    :   INTEGER
    );
    Port(
        input   : in    STD_LOGIC_VECTOR(bitwidth_in-1 DOWNTO 0);
        output  : out   STD_LOGIC_VECTOR(bitwidth_out-1 DOWNTO 0);
        sign    : in    STD_LOGIC   --signed if 0, unsigned if 1
    );
end Sign_extend;

architecture Behavioral of Sign_extend is

begin

    mux_process:process(input, sign)
    begin
        if(sign='0') then
            output <= std_logic_vector(to_signed(to_integer(signed(input)), bitwidth_out));
        else
            output <= std_logic_vector(to_unsigned(to_integer(unsigned(input)), bitwidth_out));
        end if;
     end process;

end Behavioral;
