


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UART_tb is
   
end UART_tb;

architecture Behavioral of UART_tb is

    component UART is
        Generic(
           baud_rate: NATURAL:= 9600
       );
       Port ( 
           clk_i:       in      std_logic;                         --Clocl
           data_i:      in      std_logic_vector(31 downto 0);      --Data om te sturen
           start_tx_i:  in      std_logic;                         --Start met zenden
           
           data_o:      out      std_logic_vector(31 downto 0);       --ONtvangen data
           rx_received: out     std_logic;                         --SIgnaal dat we ontvangen hebben
           
           RX_i:        in         std_logic;
           TX_o:        out         std_logic;
           busy:        out     std_logic
       );
    end component UART;
    
    signal clk_i: std_logic := '0';
    signal data_o: std_logic_vector(31 downto 0) := (others=>'0');
    signal rx_received: std_logic := '0';
    signal RX_i:    std_logic := '0';
    
    signal TX_o:        std_logic := '1';
    signal TX_i:        std_logic := '0';
    signal data_i:      std_logic_vector(31 downto 0) := x"12345678";
    signal start_tx_i:  std_logic := '0';
    signal busy:        std_logic := '0';
    
    constant clk_i_period : time := 10ns;
    constant baud_period: time := 52083ns;
    

begin

    uut:UART 
    generic map(
        baud_rate => 9600
        )
    Port map(
        clk_i => clk_i,
        start_tx_i => start_tx_i,
        
        data_o => data_o,
        data_i => data_i,
        rx_received => rx_received, 
        RX_i => RX_i,
        TX_o => TX_o, 
        busy => busy
        );

    clk_i_process :process
    begin
        clk_i <= '0';
        wait for clk_i_period/2;
        clk_i <= '1';
        wait for clk_i_period/2;
    end process;
    
    stimulus:process
    begin
        RX_i <= '1';
        
        wait for 100ns;
        
        RX_i <= '0';
        wait for baud_period;
        
        RX_i <= '1';
        wait for baud_period;
        RX_i <= '0';
        wait for baud_period;
        RX_i <= '0';
        wait for baud_period;
        RX_i <= '0';
        wait for baud_period;
        RX_i <= '0';
        wait for baud_period;
        RX_i <= '0';
        wait for baud_period;
        RX_i <= '1';
        wait for baud_period;
        RX_i <= '0';
        wait for baud_period;
        RX_i <= '1';
        wait for baud_period;
        RX_i <= '0';
        wait for baud_period;
        RX_i <= '0';
        wait for baud_period;
        RX_i <= '0';
        wait for baud_period;
        RX_i <= '0';
        wait for baud_period;
        RX_i <= '0';
        wait for baud_period;
        RX_i <= '1';
        wait for baud_period;
        RX_i <= '0';
        wait for baud_period;
        RX_i <= '1';
        wait for baud_period;
        RX_i <= '0';
        wait for baud_period;
        RX_i <= '0';
        wait for baud_period;
        RX_i <= '0';
        wait for baud_period;
        RX_i <= '0';
        wait for baud_period;
        RX_i <= '0';
        wait for baud_period;
        RX_i <= '1';
        wait for baud_period;
        RX_i <= '0';
        wait for baud_period;
        RX_i <= '1';
        wait for baud_period;
        RX_i <= '0';
        wait for baud_period;
        RX_i <= '0';
        wait for baud_period;
        RX_i <= '0';
        wait for baud_period;
        RX_i <= '0';
        wait for baud_period;
        RX_i <= '0';
        wait for baud_period;
        RX_i <= '1';
        wait for baud_period;
        RX_i <= '0';
        wait for baud_period;
        
        RX_i <= '1';
        wait for baud_period * 2;
                                                                
        wait for 10* clk_i_period;
        
        start_tx_i <= '1';
        
        wait for 2*clk_i_period;
        
        start_tx_i <= '0';
        
        
        wait;
        end process stimulus;
         
end Behavioral;
