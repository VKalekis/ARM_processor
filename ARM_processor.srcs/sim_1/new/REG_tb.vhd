----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Vasilis Kalekis - HA 2020507
-- 
-- Create Date: 04.03.2021 15:35:12
-- Design Name: ARM Processor 
-- Module Name: REG_tb - Behavioral
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

entity REG_tb is
--  Port ( );
end REG_tb;

architecture Behavioral of REG_tb is
    component REG_n is
   
    port (
        CLK, RESET, WE : in STD_LOGIC;
        D: in STD_LOGIC_VECTOR (32-1 downto 0);
        Q: out STD_LOGIC_VECTOR (32-1 downto 0));   
end component;

    constant CLK_period : time := 50 ns;
     signal CLK, RESET : STD_LOGIC;
     signal Q, D : STD_LOGIC_VECTOR(31 downto 0);

begin
    
    REG: REG_n
    port map(
        CLK=>CLK,
        RESET=>RESET,
        WE=>'1',
        Q=>Q,
        D=>D);
    
    CLK_process : process
    begin
        CLK <= '0';
        wait for CLK_period/2;
        CLK <= '1';
        wait for CLK_period/2;
    end process;        
    
    stimulus_process: process
    begin
        -- RESET deasserted on CLK falling edge
        RESET <= '1';
        wait for 100 ns;
        wait until (CLK = '0' and CLK'event);
        RESET <= '0'; 
        
        wait for CLK_period;
        wait for CLK_period;
        wait for CLK_period;
        wait for CLK_period;
        end process;
end Behavioral;
