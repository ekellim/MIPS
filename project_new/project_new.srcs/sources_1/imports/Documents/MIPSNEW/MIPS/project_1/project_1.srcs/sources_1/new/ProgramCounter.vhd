library IEEE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------------
entity ProgramCounter is
    Port ( clk      : in    STD_LOGIC;
           reset    : in    STD_LOGIC;
           pc_in    : in    STD_LOGIC_VECTOR (31 downto 0);
           pc_out   : out   STD_LOGIC_VECTOR (31 downto 0) := (others => '0')
           );
end ProgramCounter;

----------------------------------------------------------------------------------
architecture Behavioral of ProgramCounter is

begin
    programCounterProcess:process(clk,reset)
    variable pc:        STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    variable counter:   INTEGER := 0;
    
    begin
    if(reset = '1') then
        pc := (others => '0');
        pc_out <= pc;
        counter := 0;
    elsif(rising_edge(clk)) then
        if counter = 5 then
            pc_out <= pc;
            counter := 1;
        else
            counter := counter + 1;
        end if;
        pc := pc_in;
    end if;
    
    end process;

end Behavioral;