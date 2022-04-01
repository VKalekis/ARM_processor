----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Vasilis Kalekis - HA 2020507
-- 
-- Create Date: 01.03.2021 16:33:23
-- Design Name: ARM Processor
-- Module Name: ADD_SUB - Behavioral
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

entity ADD_SUB is
    generic (WIDTH : positive := 32);
    port (
        SrcA, SrcB : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
        ALUControl : in STD_LOGIC_VECTOR (2 downto 0);
        ADD_SUB_result : out STD_LOGIC_VECTOR (WIDTH-1 downto 0);
        C_inV_in : out STD_LOGIC_VECTOR (1 downto 0));
end ADD_SUB;

architecture Behavioral of ADD_SUB is

begin
    ADD_SUB: process (SrcA, SrcB, ALUControl)
    variable A_s, B_s, S_s: SIGNED (WIDTH+1 downto 0);
    variable temp : STD_LOGIC_VECTOR (WIDTH-1 downto 0);
    begin
	
        A_s := signed('0' & SrcA(WIDTH-1) & SrcA); 
        
        if (ALUControl = "000") then 
           
            B_s := signed('0' & SrcB(WIDTH-1) & SrcB);
            S_s := A_s + B_s;
            
        elsif (ALUControl = "001") then
        
            temp := std_logic_vector(unsigned( not(SrcB))+1 );            
            B_s := signed('0' & temp(WIDTH-1) & temp);
            S_s := A_s + B_s;
            
        end if;
        
        ADD_SUB_result <= std_logic_vector(S_s(WIDTH-1 downto 0)); 
        C_inV_in(0) <= S_s(WIDTH) xor S_s(WIDTH-1);
        C_inV_in(1) <= S_s(WIDTH+1);
    end process;


end Behavioral;
