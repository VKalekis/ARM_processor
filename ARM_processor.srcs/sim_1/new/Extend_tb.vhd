----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Vasilis Kalekis - HA 2020507
-- 
-- Create Date: 04.03.2021 16:26:11
-- Design Name: ARM Processor
-- Module Name: Extend_tb - Behavioral
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

entity Extend_tb is
--  Port ( );
end Extend_tb;

architecture Behavioral of Extend_tb is
    component Extend is
    generic (WIDTH : positive := 32);
     port ( 
        X: in STD_LOGIC_VECTOR (23 downto 0);
        S : in STD_LOGIC;
        Y: out STD_LOGIC_VECTOR (WIDTH-1 downto 0));
end component;
    
    signal S_tb:STD_LOGIC;
    signal X_tb:STD_LOGIC_VECTOR(23 downto 0);
    signal Y_tb:STD_LOGIC_VECTOR(32-1 downto 0);
begin

    extend1: Extend
        generic map(WIDTH=>32)
        port map(X=>X_tb, S=>S_tb,Y=>Y_tb);
        
        
     proc1:process
     begin
        X_tb <= X"000000";
        
        S_tb <= '1';
        
        wait for 10ns;
               
        X_tb <= X"F00100";        
        wait for 10ns;
                
        X_tb <= X"000FFF";
        wait for 20ns;        
      
        X_tb <= X"FFFFFF";
        
        wait for 10ns;
        
        X_tb <= X"000000";
        
        S_tb <= '0';
        
        wait for 10ns;
               
        X_tb <= X"F00100";        
        wait for 10ns;
                
        X_tb <= X"000FFF";
        wait for 20ns;        
      
        X_tb <= X"FFFFFF";
        
        wait for 10ns;
     end process;
end Behavioral;
