

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.utils.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UART is
    Generic(
        baud_rate: NATURAL:= 9600
    );
    Port ( 
        clk_i:       in         std_logic;                         --Clocl
        data_i:      in         std_logic_vector(31 downto 0);      --Data om te sturen 
        start_tx_i:  in         std_logic;                         --Start met zenden
        
        data_o:      out        std_logic_vector(31 downto 0);       --ONtvangen data
        rx_received: out        std_logic;                         --SIgnaal dat we ontvangen hebben
        
        RX_i:        in         std_logic := '1';
        TX_o:        out        std_logic := '1';
        
        busy:        out        std_logic
    );
end UART;

architecture Behavioral of UART is
    signal rx_buffer:   std_logic_vector(31 downto 0) := (others=>'0'); 
    signal tx_buffer:   std_logic_vector(31 downto 0) := (others=>'0');
    signal rec_busy:     std_logic := '0';
    signal tr_busy:     std_logic := '0';
begin

    receive:process(clk_i)
        --Definitie van state type
        type state_t is (IDLE, STARTBIT, DATA, STOPBIT);
        
        --Variabel maken van state type en standaard op IDLE zetten
        variable state: state_t:=IDLE;
        variable period_counter: integer := 0;
        variable bit_counter: integer := 0;
        
    begin
        if rising_edge(clk_i) then
            
            case state is
                when IDLE =>
                    rx_received <= '0';     --zet rx_received op laag in IDLE state
                    period_counter := 0;    --reset counter
                    bit_counter := 0;
                    rec_busy <= '0';
                    if RX_i = '0' then 
                        state := STARTBIT;
                    end if;
                when STARTBIT =>
                    period_counter := period_counter + 1;
                    rec_busy <= '1';
                    if period_counter >= baudrate_to_clock_ticks(baud_rate, 50_000_000)/2 then
                        state := DATA;
                        period_counter := 0; --reset counter
                    end if;
                when DATA =>
                    period_counter := period_counter + 1;
                    rec_busy <= '1';
                    if period_counter >=baudrate_to_clock_ticks(baud_rate, 50_000_000) then 
                        period_counter := 0;
                        
                        rx_buffer(bit_counter) <= RX_i;
                        
                        bit_counter := bit_counter + 1;
                        
                        if bit_counter = 32 then 
                            state := STOPBIT;
                        end if;
                        
                        
                    end if;
                when STOPBIT =>
                    rec_busy <= '0';
                    data_o <= rx_buffer;
                    rx_received <= '1'; -- signaal geven dat we data hebben ontvangen
                    period_counter := period_counter +1;
                    if period_counter >= baudrate_to_clock_ticks(baud_rate, 50_000_000) then
                        state := IDLE;    -- NA 1 PERIODE gaan we terug naar IDLE state
                    end if;
            
            end case;
        end if;
    end process receive;
    
    send_data:process(clk_i)
        type state_t is (IDLE, STARTBIT, DATA, STOPBIT);
        variable state: state_t := IDLE;
        variable period_counter: integer := 0;
        variable bit_counter: integer := 0;
        
    begin
        if rising_edge(clk_i) then
            case state is
                when IDLE =>
                    tr_busy <= '0';
                    period_counter :=0;
                    TX_o <= '1';
                    if start_tx_i = '1' then
                        state := STARTBIT;      -- verander de state
                        tx_buffer <= data_i; --bufferen van de data die we moeten sturen
                               --tx laag startbit    
                        period_counter :=0;
                        bit_counter:= 0;            
                    end if;
                when STARTBIT=>
                    tr_busy <= '1';
                    TX_o <='0';
                    period_counter := period_counter +1;
                    if period_counter >= baudrate_to_clock_ticks(baud_rate, 50_000_000) then       
                        state := DATA;
                        period_counter := 0;
                        bit_counter := 0;
                    end if;
                when DATA=>
                    tr_busy <= '1';
                    TX_o <= tx_buffer(bit_counter);
                    period_counter := period_counter + 1;
                    if period_counter >=baudrate_to_clock_ticks(baud_rate, 50_000_000) then
                        bit_counter := bit_counter +1;
                        period_counter:= 0;
                        if bit_counter = 32 then     
                            state := STOPBIT;
                        end if;
                    end if;
                    
                    
                when STOPBIT=>
                    tr_busy <= '1';    
                    TX_o <= '1';
                    period_counter := period_counter +1;
                    if period_counter >= baudrate_to_clock_ticks(baud_rate, 50_000_000) then
                        state := IDLE;    -- NA 1 PERIODE gaan we terug naar IDLE state
                    end if;
                    
            end case;
        end if;
    end process;
    
    busy_process:process(clk_i)
    begin
        busy <= rec_busy or tr_busy;
    end process;
       

end Behavioral;