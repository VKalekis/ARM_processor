----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Vasilis Kalekis - HA 2020507
-- 
-- Create Date: 01.03.2021 16:53:04
-- Design Name: ARM Processor
-- Module Name: AND_OR - Behavioral
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

entity AND_XOR is
    generic (WIDTH : positive := 32);
    port (
        SrcA, SrcB : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
        ALUControl : in STD_LOGIC_VECTOR (2 downto 0);
        AND_XOR_result : out STD_LOGIC_VECTOR (WIDTH-1 downto 0));
end AND_XOR;

architecture Behavioral of AND_XOR is

begin
    
    AND_XOR: process (SrcA, SrcB, ALUControl)
    begin
        if (ALUControl = "010") then --AND
            AND_XOR_result <= SrcA and SrcB;
        elsif (ALUControl = "011") then --XOR
            AND_XOR_result <= SrcA xor SrcB;
        end if;
    end process;
end Behavioral;
