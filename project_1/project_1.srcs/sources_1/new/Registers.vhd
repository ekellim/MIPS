----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2020 02:31:11 PM
-- Design Name: 
-- Module Name: Registers - Behavioral
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

entity Registers is
      Port (
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
end Registers;

architecture Behavioral of Registers is

    subtype reg_32bit is STD_LOGIC_VECTOR(31 downto 0);
    type regs_32bit is array(0 to 31) of reg_32bit;
    
    signal regs:regs_32bit:=(
    0=> x"00000000",            -- $zero
    1=> x"00000000",            -- $at
    2 to 3=> x"00000000",       -- $v0-$v1
    4 to 7=> x"00000000",       -- $a0-$a3
    8 to 15=> x"00000000",      -- $t0-$t7
    16 to 23=> x"00000000",     -- $s0-$s7
    24 to 25=> x"00000000",     -- $t8-$t9
    26 to 27=> x"00000000",     -- $k0-$k1
    28 => x"00000000",          -- $gp
    29 => x"00000000",          -- $sp
    30 => x"00000000",          -- $fp
    31 => x"00000000"          -- $ra    
    );

begin
    
    readwrite_Process:process(clk, reset)
    begin      
        if (reg_write = '1') and (to_integer(unsigned(write_reg)) > 0)then
            regs(to_integer(unsigned(write_reg))) <= write_data;
        end if;
        
        if(reset = '1') then
            regs <= (others => x"00000000");
        elsif(rising_edge(clk)) then
            read_data_1 <= regs(to_integer(unsigned(read_reg_1)));
            read_data_2 <= regs(to_integer(unsigned(read_reg_2)));
        end if;             
    end process;
        

end Behavioral;