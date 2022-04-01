----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Vasilis Kalekis - HA 2020507
-- 
-- Create Date: 01.03.2021 19:33:37
-- Design Name: ARM Processor
-- Module Name: Extend - Behavioral
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

entity Extend is
    generic (WIDTH : positive := 32);
     port ( 
        X: in STD_LOGIC_VECTOR (23 downto 0);
        S : in STD_LOGIC;
        Y: out STD_LOGIC_VECTOR (WIDTH-1 downto 0));
end Extend;

architecture Behavioral of Extend is

    
begin

    Extend: process(X, S)
        variable Y_u : UNSIGNED (WIDTH-1 downto 0);
        variable Y_S : SIGNED (WIDTH-1 downto 0);
    begin
        
        if ( S='0' ) then
            Y_u := resize(unsigned(X(11 downto 0)), WIDTH);
            Y<= std_logic_vector(Y_u);
            
        else 
            Y_s := resize(signed(X(23 downto 0)&"00"), WIDTH);
            Y<= std_logic_vector(Y_s);
        end if;
        
        
        
    end process;  
end Behavioral;
