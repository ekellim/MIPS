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
    readData    : out STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
    uartSend    : out STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
    startSend   : out STD_LOGIC;
    uartReceive : in  STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
    received    : in  STD_LOGIC
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

    signal data_send    :   STD_LOGIC_VECTOR(31 DOWNTO 0) := x"00000000";
begin
    dataMemoryProcess:process(clk)
    begin
        if(reset = '1') then
                DM <= (others => (others => '0'));
        elsif(rising_edge(clk)) then
            startSend <= '0';
            if (memWrite = '1') then
                 DM(to_integer(unsigned(address))) <= writeData;
                 if (to_integer(unsigned(address)) = 63) then
                    uartSend  <= writeData;
                    if (writeData = data_send) then
                        
                    else
                        startSend <= '1';
                        data_send <= writeData;
                    end if;
                 end if;
            end if;
            if (memRead = '1') then
                 readData <= DM(to_integer(unsigned(address)));
            end if;
            if (received = '1') then
                DM(62) <= uartReceive;
            end if;
        end if;
    end process;
    



end Behavioral;
