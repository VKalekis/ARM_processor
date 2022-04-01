----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Vasilis Kalekis - HA 2020507
-- 
-- Create Date: 03.03.2021 19:02:48
-- Design Name: ARM Processor
-- Module Name: PCLogic - Behavioral
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

entity PCLogic is       
    port (
        Rd : in STD_LOGIC_VECTOR (3 downto 0);
        op : in STD_LOGIC_VECTOR (1 downto 0);
        RegWrite_in : in STD_LOGIC;
        
        PCSrc_in : out STD_LOGIC);
end PCLogic;

architecture Behavioral of PCLogic is
          
begin 

    check_Rd_op1_RegWrite_in: process(Rd, op, RegWrite_in)
        variable op_and_RegWrite_in : STD_LOGIC_VECTOR (2 downto 0);
        
    begin
        op_and_RegWrite_in := op & RegWrite_in;
        case op_and_RegWrite_in is 
                when "001" => -- data processing and RegWrite_in=1
                    case Rd is 
                        when "1111" =>
                            PCSrc_in <= '1';
                        when others =>
                            PCSrc_in <= '0';
                    end case;
                 
                when "000" =>  -- CMP and RegWrite_in=0
                    PCSrc_in <= '0'; --Rd = XXXX, dont care      
                
                when "011" => -- LDR and RegWrite_in=1
                    case Rd is 
                        when "1111" =>
                            PCSrc_in <= '1';
                        when others =>
                            PCSrc_in <= '0';
                    end case;
                
                when "010" => -- STR and RegWrite_in=0
                    PCSrc_in <= '0'; --Rd = XXXX, dont care
                
                when "100" => -- B and RegWrite_in=0
                    PCSrc_in <= '1'; --Rd = XXXX, dont care                            
                
                when others =>
                    PCSrc_in <= 'X';
        end case;    
    end process;

end Behavioral;
