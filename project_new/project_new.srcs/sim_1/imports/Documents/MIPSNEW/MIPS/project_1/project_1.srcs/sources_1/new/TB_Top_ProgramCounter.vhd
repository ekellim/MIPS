library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Top_ProgramCounter is
end TB_Top_ProgramCounter;

architecture Behavioral of TB_Top_ProgramCounter is

    ----------------------------------------------------------------------------------
    component Top_ProgramCounter is
    Port (
        clk     : in    STD_LOGIC;
        reset   : in    STD_LOGIC;
        PC      : out   STD_LOGIC_VECTOR(31 downto 0) := (others => '0')
        );
    end component;
    
    -- Input signalen
    signal clk      : STD_LOGIC := '0';
    signal reset    : STD_LOGIC := '0';
    
    -- Output signalen
    signal PC       : STD_LOGIC_VECTOR(31 downto 0);
    
    -- Constanten
    constant clk_period : time := 10 ns;

begin
    uut: Top_ProgramCounter
    port map(
        clk     => clk,
        reset   => reset,
        PC      => PC
        );

    -- Aanmaken van clock process
    clk_process : process
    begin
        clk <= '1';
        wait for clk_period/2;
        clk <= '0';
        wait for clk_period/2;
    end process;


    -- Aanmaken van het simulatie process
    sim_process : process
    begin
        -- Wacht tijd voor reset
        wait for 500 ns;
        reset <= '1';
        wait for 5 ns;
        reset <= '0';
        wait;
        
    end process;
end Behavioral;
