----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Vasilis Kalekis - HA 2020507
-- 
-- Create Date: 03.03.2021 18:25:56
-- Design Name: ARM Processor
-- Module Name: WELogic - Behavioral
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

entity WELogic is    
    port (
        op : in STD_LOGIC_VECTOR (1 downto 0);
        S : in STD_LOGIC;
        L : in STD_LOGIC;
        NoWrite_in : in STD_LOGIC;
        
        RegWrite_in : out STD_LOGIC;
        MemWrite_in : out STD_LOGIC;
        FlagsWrite_in : out STD_LOGIC);
end WELogic;

architecture Behavioral of WELogic is

begin
    
    check_op_SL_NoWrite_in: process(op, S, L, NoWrite_in)
        variable S_and_NoWrite_in : STD_LOGIC_VECTOR (1 downto 0);
        variable flags_out : STD_LOGIC_VECTOR (2 downto 0);
    begin
        S_and_NoWrite_in := S & NoWrite_in;
        case op is 
            when "00" =>
               
                case S_and_NoWrite_in is
                    when "00" => -- data processing, S=0, NoWrite_in=0
                        flags_out := "100";
                    when "10" => -- data processing, S=1, NoWrite_in=0
                        flags_out := "101";
                    when "11" => -- CMP, S=1, NoWrite_in=1
                        flags_out := "001";
                        
                    when others =>
                        flags_out := "XXX";  
                end case;
                     
            when "01" =>                
                case S_and_NoWrite_in is
                    when "10" => -- LDR, S=1, NoWrite_in=0
                        flags_out := "100";
                    when "00" => -- STR, S=0, NoWrite_in=0
                        flags_out := "010";
                        
                    when others =>
                        flags_out := "XXX";  
                end case;
           
           when "10" =>
               
                if ((NoWrite_in = '0') and (L = '0')) then
                     flags_out := "000";  -- B, S=X, NoWrite_in=0
                elsif ((NoWrite_in = '0') and (L = '1')) then
                    flags_out := "100"; -- BL, writes to register 14
                else
                    flags_out := "XXX";
                end if;                
          
           when others =>
                flags_out := "XXX";                
          
        end case;                
        
         RegWrite_in <= flags_out(2);
         MemWrite_in <= flags_out(1);
         FlagsWrite_in <= flags_out(0);
    end process;
end Behavioral;
