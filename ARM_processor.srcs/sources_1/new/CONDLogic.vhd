----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Vasilis Kalekis - HA 2020507
-- 
-- Create Date: 03.03.2021 19:22:33
-- Design Name: ARM Processor
-- Module Name: CONDLogic - Behavioral
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

entity CONDLogic is
    port (
        cond : in STD_LOGIC_VECTOR(3 downto 0);
        Flags : in STD_LOGIC_VECTOR(3 downto 0); --NZCV
        
        CondEx_in : out STD_LOGIC);
end CONDLogic;

architecture Behavioral of CONDLogic is

begin
    
    check_cond: process(cond, Flags) 
    begin
        case cond is 
            --NZCV
            when "0000" => -- EQ -> Z
                CondEx_in <= Flags(2); 
                
            when "0001" => -- NE -> not Z 
                CondEx_in <=  not Flags(2);           
            
            when "0010" => -- CS / HS (unsigned higher) -> C
                CondEx_in <= Flags(1); 
                
            when "0011" => -- CC / LO (unsigned lower) -> not C
                CondEx_in <=  not Flags(1);
                
            when "0100" => -- MI (negative) -> N
                CondEx_in <= Flags(3); 
                
            when "0101" => -- PL (positive or 0) -> not N
                CondEx_in <=  not Flags(3);  
                
            when "0110" => -- VS (overflow - overflow set) -> V
                CondEx_in <= Flags(0); 
                
            when "0111" => -- VC (no overflow - overflow clear) -> not V
                CondEx_in <=  not Flags(0);     
            
            when "1000" => -- HI (unsigned higher) -> ( not Z ) * C
                CondEx_in <= (not Flags(2)) and Flags(1); 
                
            when "1001" => -- LS (unsigned lower or same) ->  not ( not Z ) * C
                CondEx_in <=  not ((not Flags(2)) and Flags(1)); 
            
            when "1010" => -- GE (signed greater or equal) -> not ( N xor V )
                CondEx_in <= not ( Flags(3) xor Flags(0) ); 
                
            when "1011" => -- LT (signed less) ->  N xor V
                CondEx_in <=  Flags(3) xor Flags(0); 
                
            when "1100" => -- GT (signed greater) -> not Z * not ( N xor V ) = not (Z + N xor V)
                CondEx_in <= not (Flags(2) or ( Flags(3) xor Flags(0) )); 
                
            when "1101" => -- LE (signed less or equal) ->  Z + N xor V
                CondEx_in <=  Flags(2) or ( Flags(3) xor Flags(0) );
                
            when "1110" => -- AL/none (always/unconditional) ->  1
                CondEx_in <=  '1'; 
            
            when "1111" => -- none (unconditional) ->  1
                CondEx_in <=  '1'; 
            
            when others =>
                CondEx_in <= 'X';    
    end case;
    end process;
end Behavioral;
