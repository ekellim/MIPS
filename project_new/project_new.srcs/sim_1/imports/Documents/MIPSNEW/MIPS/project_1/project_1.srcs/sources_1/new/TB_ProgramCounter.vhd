library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_ProgramCounter is
end TB_ProgramCounter;

architecture Behavioral of TB_ProgramCounter is

    -- Declaratie van het blokje dat we gaan testen
    component ProgramCounter is
        Port ( clk      : in    STD_LOGIC;
               reset    : in    STD_LOGIC;
               pc_in    : in    STD_LOGIC_VECTOR (31 downto 0);
               pc_out   : out   STD_LOGIC_VECTOR (31 downto 0) := (others => '0')
               );
    end component;
    
    -- Input signalen
    signal clk      : STD_LOGIC := '0';
    signal reset    : STD_LOGIC := '0';
    signal pc_in    : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    
    -- Output signalen
    signal pc_out   : STD_LOGIC_VECTOR(31 downto 0);
    
    -- Constanten
    constant clk_period : time := 10 ns;

begin
    uut: ProgramCounter
    port map(
        clk     => clk,
        reset   => reset,
        pc_in   => pc_in,
        pc_out  => pc_out
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
        wait for 100 ns;
        
        -- Bein van de logica
        pc_in <= x"00000004";
        wait for clk_period;
        pc_in <= x"00000008";
        wait for 2 ns;
        reset <= '1';
        wait for 3 ns;
        reset <= '0';
        wait for 5 ns;
        pc_in <= x"00000004";
        wait for clk_period;
        pc_in <= x"00000008";
        wait for clk_period;
        pc_in <= x"0000000C";
        
        wait;
        
    end process;

end Behavioral;
