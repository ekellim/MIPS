
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package utils is 
    
    -- THis function calculates the clock ticks using the baud rate
    -- and the frequency of the FPGA
    --
    -- baud_rate: the baud rate
    -- frequency: the frequency of the FPGA
    -- return: clock ticks for one period
    function baudrate_to_clock_ticks(baud_rate:NATURAL; frequency:NATURAL) return Natural;
    
    --THis function calculates the log with base 2 of a number
    --
    -- getal: input number
    -- return result of log2
    function log2(getal: NATURAL) return NATURAL;
end utils;

package body utils is 
    
    function baudrate_to_clock_ticks(baud_rate:NATURAL; frequency:NATURAL) return NATURAL is 
    
    begin
        return frequency / baud_rate;
    end function baudrate_to_clock_ticks;
    
    function log2(getal: NATURAL) return NATURAL is
        variable counter: NATURAL := 0;
        variable jos: Natural := getal;
    begin
        while jos > 0 loop
            jos := jos/2;
            counter := counter + 1;
        end loop;
        return counter;
    end function log2;
    
end utils;
