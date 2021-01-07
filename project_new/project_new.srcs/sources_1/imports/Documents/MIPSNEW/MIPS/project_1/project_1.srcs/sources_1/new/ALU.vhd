----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/16/2020 02:04:47 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
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

entity ALU is
  Port ( 
    clk                 : in STD_LOGIC;
    input_0             : in STD_LOGIC_VECTOR(31 DOWNTO 0);
    input_1             : in STD_LOGIC_VECTOR(31 DOWNTO 0);
    alu_control_in      : in STD_LOGIC_VECTOR(3 DOWNTO 0);
    shamt               : in STD_LOGIC_VECTOR(4 DOWNTO 0);
    zero                : out STD_LOGIC;
    overflow            : out STD_LOGIC;
    ALU_res             : out STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
end ALU;

architecture Behavioral of ALU is

begin

    alu_process:process(clk)
        variable RESULT : STD_LOGIC_VECTOR(31 DOWNTO 0);
        variable RESULT64:STD_LOGIC_VECTOR(63 DOWNTO 0);
        variable Hi : STD_LOGIC_VECTOR(31 DOWNTO 0);
        variable Lo : STD_LOGIC_VECTOR(31 DOWNTO 0);
        variable test : INTEGER;
    begin
        if(rising_edge(clk)) then
            overflow <= '0';
            case alu_control_in is
                when "0000" =>                                      --AND
                    RESULT := input_0 and input_1;
                when "0001" =>                                      --OR
                    RESULT := input_0 or input_1;
                when "0010" =>                                      --ADD
                    RESULT := std_logic_vector(signed(input_0) + signed(input_1));
                when "1000" =>                                      --ADDU
                    RESULT := std_logic_vector(unsigned(input_0) + unsigned(input_1));
                when "0011" =>                                      --NOR
                    RESULT := input_0 nor input_1;
                when "0110" =>                                      --SUBTRACT
                    RESULT := std_logic_vector(signed(input_0) - signed(input_1));
                when "0111" =>                                      --SET ON LESS THAN
                    if signed(input_0) < signed(input_1) then
                        RESULT := std_logic_vector(to_signed(1, 32));
                    else
                        RESULT := std_logic_vector(to_signed(0, 32));
                    end if;
                when "0100" =>                                      -- SHIFT LEFT LOGICAL
                    RESULT := std_logic_vector(signed(input_1) sll to_integer(unsigned(shamt)));
                when "0101" =>                                      -- SHIFT RIGHT LOGICAL
                    RESULT := std_logic_vector(signed(input_1) srl to_integer(unsigned(shamt)));
                    --RESULT := std_logic_vector("00" & input_0(31 downto 2));
                    --RESULT := std_logic_vector(shift_right(signed(input_0), 2));
                when "1001" =>                                      --DIV
                    if (input_1 = x"00000000") then        
                        overflow <= '1';
                        Lo :=  x"01111111";
                        Hi :=  x"01111111";
                    else
                        Lo := std_logic_vector(to_signed(to_integer(signed(input_0)) / to_integer(signed(input_1)),32));
                        Hi := std_logic_vector(to_signed(to_integer(signed(input_0)) mod to_integer(signed(input_1)),32));       
                    end if;      
                when "1010" =>                                       --MULT
                    RESULT64 := std_logic_vector(signed(input_0) * signed(input_1));
                    Hi := RESULT64(63 DOWNTO 32);
                    Lo := RESULT64(31 DOWNTO 0);
                when "1011" =>                                      --MFLO
                    RESULT := Lo;
                when "1100" =>                                      --MFHI
                    RESULT := Hi;
                when others =>
                    RESULT := x"ffffffff";   
            end case;
            if RESULT = x"00000000" then
                zero <= '1';
            else 
                zero <='0';
            end if;
            ALU_res <= RESULT;
        end if;
    end process;

end Behavioral;
