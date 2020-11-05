----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/13/2020 12:01:55 AM
-- Design Name: 
-- Module Name: Adder - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Adder is
Port (
    clk         : in        STD_LOGIC;
    input1      : in        STD_LOGIC_VECTOR(31 downto 0);
    input2      : in        STD_LOGIC_VECTOR(31 downto 0);
    output      : out       STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    reset       : in        STD_LOGIC
);
end Adder;

architecture Behavioral of Adder is

begin
    AdderProcess:process(clk, reset)
    begin
        if (reset ='1') then
            output <= STD_LOGIC_VECTOR(to_unsigned(0, 32));
        elsif(rising_edge(clk)) then
            output <= input1 + input2;
        end if;
    end process;
end Behavioral;
