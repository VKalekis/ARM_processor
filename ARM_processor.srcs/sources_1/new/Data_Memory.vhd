----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Vasilis Kalekis - HA 2020507
-- 
-- Create Date: 01.03.2021 22:03:57
-- Design Name: ARM Processor
-- Module Name: Data_Memory - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Data_Memory is
    generic (
        N : positive := 5;
        M : positive := 32);     
    port (
        CLK, WE : in STD_LOGIC;
        A : in STD_LOGIC_VECTOR (N-1 downto 0);
        WD : in STD_LOGIC_VECTOR (M-1 downto 0);
        RD : out STD_LOGIC_VECTOR (M-1 downto 0));
        
end Data_Memory;

architecture Behavioral of Data_Memory is
    
    type DM_array is array (2**N-1 downto 0)
        of STD_LOGIC_VECTOR (M-1 downto 0);
    signal DM : DM_array;
begin

    Distributed_RAM: process (CLK)
    begin
        if (CLK = '1' and CLK'event) then
            if (WE = '1') then 
                DM(to_integer(unsigned(A))) <= WD;
            end if;
        end if;
    end process;
    
    RD <= DM(to_integer(unsigned(A)));
    
end Behavioral;
