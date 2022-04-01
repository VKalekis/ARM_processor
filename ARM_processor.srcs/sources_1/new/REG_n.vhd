----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Vasilis Kalekis - HA 2020507
-- 
-- Create Date: 28.02.2021 12:08:29
-- Design Name: ARM Processor
-- Module Name: REG_n - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity REG_n is
    generic (WIDTH : positive := 32);
    port (
        CLK, RESET, WE : in STD_LOGIC;
        D: in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
        Q: out STD_LOGIC_VECTOR (WIDTH-1 downto 0));   
end REG_n;

architecture Behavioral of REG_n is

begin
    
    process (CLK)
    begin
        if (CLK = '1' and CLK'event) then
            if (RESET = '1') then
                Q <= (others => '0');
            elsif (WE = '1') then
                Q <= D;
            end if;
        end if;
    end process;
    
end Behavioral;
