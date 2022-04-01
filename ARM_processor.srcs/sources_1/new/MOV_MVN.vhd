----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Vasilis Kalekis - HA 2020507
-- 
-- Create Date: 04.03.2021 12:13:07
-- Design Name: ARM Processor
-- Module Name: MOV_MVN - Behavioral
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

entity MOV_MVN is
    generic (WIDTH : positive := 32);
    port (
        SrcB : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
        ALUControl : in STD_LOGIC_VECTOR (2 downto 0);
        MOV_MVN_result : out STD_LOGIC_VECTOR (WIDTH-1 downto 0));
end MOV_MVN;

architecture Behavioral of MOV_MVN is

begin
    
    MOV_MVN: process (SrcB, ALUControl)
    begin
        if (ALUControl = "100") then --MOV
            MOV_MVN_result <= SrcB;
        elsif (ALUControl = "101") then --MVN
            MOV_MVN_result <= not SrcB;
        end if;
    end process;

end Behavioral;
