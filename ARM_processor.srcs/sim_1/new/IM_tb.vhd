----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Vasilis Kalekis - HA 2020507
-- 
-- Create Date: 04.03.2021 15:59:23
-- Design Name: ARM Processor
-- Module Name: IM_tb - Behavioral
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

entity IM_tb is
   
end IM_tb;

architecture Behavioral of IM_tb is
    
    component Instruction_Memory is
     generic (
        N : positive := 6;
        WIDTH : positive := 32);    
    
    port(
        A : in STD_LOGIC_VECTOR (N-1 downto 0);
        RD : out STD_LOGIC_VECTOR (WIDTH-1 downto 0));
end component;

    signal A : STD_LOGIC_VECTOR (6-1 downto 0);
    signal RD : STD_LOGIC_VECTOR(32-1 downto 0);
begin
    
    IM: Instruction_Memory
        generic map(
            N=>6,WIDTH=>32)
        port map(
            A=>A,RD=>RD);
            
      stim: process
      begin
      A<="000000";
      wait for 10ns;
      A<="000001";
      wait for 10ns;
      end process;
end Behavioral;
