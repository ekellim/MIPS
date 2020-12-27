----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/24/2020 06:46:33 AM
-- Design Name: 
-- Module Name: TB_sign_extend - Behavioral
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

entity TB_sign_extend is
--  Port ( );
end TB_sign_extend;

architecture Behavioral of TB_sign_extend is

    component Sign_extend
        Generic(
            bitwidth_in     :   INTEGER;
            bitwidth_out    :   INTEGER
        );
        Port(
            input   : in    STD_LOGIC_VECTOR(bitwidth_in-1 DOWNTO 0);
            output  : out   STD_LOGIC_VECTOR(bitwidth_out-1 DOWNTO 0);
            sign    : in    STD_LOGIC   --signed if 0, unsigned if 1
        );
     end component;
     
     signal input   :     STD_LOGIC_VECTOR(15 DOWNTO 0);
     signal output  :     STD_LOGIC_VECTOR(31 DOWNTO 0);
     signal sign    :     STD_LOGIC:='0';
        
     constant clk_period : time := 10 ns;
begin

    uut: Sign_extend
    generic map (bitwidth_in    => 16, 
                 bitwidth_out   =>32
                 )
    port map(
        input,
        output,
        sign
    );
    
    sim_process : process
               begin
                   sign <= '0';
                   input <= x"234";
                   wait for 20ns;
                   sign <= '1';
                   input <= x"1235";
                   wait;
               end process;

end Behavioral;
