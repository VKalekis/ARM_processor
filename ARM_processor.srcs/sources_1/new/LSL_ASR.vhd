----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Vasilis Kalekis - HA 2020507
-- 
-- Create Date: 05.03.2021 13:35:05
-- Design Name: ARM Processor
-- Module Name: LSL_ASR - Behavioral
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

entity LSL_ASR is
    generic (WIDTH : positive := 32);
    port (
        SrcB : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
        ALUControl : in STD_LOGIC_VECTOR (2 downto 0);
        shamt5 : in STD_LOGIC_VECTOR (4 downto 0);
        LSL_ASR_result : out STD_LOGIC_VECTOR (WIDTH-1 downto 0));
end LSL_ASR;

architecture Behavioral of LSL_ASR is

begin

    LSL_ASR: process (SrcB, ALUControl, shamt5)
    begin
        if (ALUControl = "110") then --LSL
            LSL_ASR_result <= std_logic_vector( shift_left( unsigned(SrcB), to_integer(unsigned(shamt5)) ) );
        elsif (ALUControl = "111") then --ASR
            LSL_ASR_result <= std_logic_vector( shift_right( signed(SrcB), to_integer(unsigned(shamt5)) ) );
        end if;
    end process;
    
end Behavioral;
