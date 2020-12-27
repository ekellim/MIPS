----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.11.2020 13:31:24
-- Design Name: 
-- Module Name: dataMemory - Behavioral
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

entity dataMemory is
    Port ( 
    clk         : in STD_LOGIC;
    reset       : in STD_LOGIC;
    address     : in STD_LOGIC_VECTOR (31 downto 0);
    writeData   : in STD_LOGIC_VECTOR (31 downto 0);
    memRead     : in STD_LOGIC;
    memWrite    : in STD_LOGIC;
    readData    : out STD_LOGIC_VECTOR (31 downto 0) := (others => '0')
    );
end dataMemory;

architecture Behavioral of dataMemory is
--dmem is RAM 64x32. 64 locations each 32bit wide
    type ram is array(0 to 63) of STD_LOGIc_VECTOR(31 downto 0);
    signal DM : ram :=(
        x"00000000", 
        x"00000000",
        x"00000000",
        x"00000000",
        x"00000000",
        x"00000000",
        x"00000000",
        x"00000000",
        x"00000001",
        x"00000002",
        x"00000003",
        x"00000000",
        x"00000000",
        x"00000000",
        x"00000000",
        x"00000000", 
        others => (others => '0')
    );

begin

    dataMemoryProcess:process(clk)
    begin
        if(reset = '1') then
                DM <= (others => (others => '0'));
        elsif(rising_edge(clk)) then
            if (memWrite = '1') then
                 DM(to_integer(unsigned(address))) <= writeData;
            end if;
            if (memRead = '1') then
                 readData <= DM(to_integer(unsigned(address)));
            end if;
        end if;
    end process;


end Behavioral;
