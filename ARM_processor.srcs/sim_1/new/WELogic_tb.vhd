----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Vasilis Kalekis - HA 2020507
-- 
-- Create Date: 06.03.2021 21:07:43
-- Design Name: ARM processor
-- Module Name: WELogic_tb - Behavioral
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

entity WELogic_tb is
--  Port ( );
end WELogic_tb;

architecture Behavioral of WELogic_tb is
    component WELogic is    
    port (
        op : in STD_LOGIC_VECTOR (1 downto 0);
        S : in STD_LOGIC;
        L : in STD_LOGIC;
        NoWrite_in : in STD_LOGIC;
        
        RegWrite_in : out STD_LOGIC;
        MemWrite_in : out STD_LOGIC;
        FlagsWrite_in : out STD_LOGIC);
     end component;
     
     signal op_tb :  STD_LOGIC_VECTOR (1 downto 0);
     signal S_tb, L_tb, NoWrite_tb, RegWrite_tb, MemWrite_tb, FlagsWrite_tb : STD_LOGIC;
     constant CLK_period : time := 10.000 ns;
     
begin

    test: WELogic
       port map(
        op => op_tb,
        S => S_tb,           
        L => L_tb,
        NoWrite_in => NoWrite_tb,

        RegWrite_in => RegWrite_tb,
        MemWrite_in =>MemWrite_tb,
        FlagsWrite_in => FlagsWrite_tb);
    
    test1: process
    begin
    op_tb <= "10";
    S_tb <= '0';
    L_tb <= '0';
    NoWrite_tb <= '0';
    wait for CLK_period;
    op_tb <= "10";
    S_tb <= '0';
    L_tb <= '1';
    NoWrite_tb <= '0';
    wait for CLK_period;
    end process;
end Behavioral;