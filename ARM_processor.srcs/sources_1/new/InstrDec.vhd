----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Vasilis Kalekis - HA 2020507
-- 
-- Create Date: 03.03.2021 17:07:45
-- Design Name: ARM Processor
-- Module Name: InstrDec - Behavioral
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

entity InstrDec is 
    port (
        op : in STD_LOGIC_VECTOR (1 downto 0);
        funct : in STD_LOGIC_VECTOR (5 downto 0);
        sh : in STD_LOGIC_VECTOR (1 downto 0);        
        RegSrc : out STD_LOGIC_VECTOR (2 downto 0); -- twra einai 3 bit, bazw extra bit sthn arxh
        ALUSrc : out STD_LOGIC;
        ImmSrc : out STD_LOGIC;
        ALUControl : out STD_LOGIC_VECTOR (2 downto 0);
        MemtoReg : out STD_LOGIC;
        NoWrite_in : out STD_LOGIC);
end InstrDec;

architecture Behavioral of InstrDec is 
    
begin
    
    check_op_and_funct: process (op, funct, sh)
        variable flags : STD_LOGIC_VECTOR (9 downto 0);
        -- flags = RegSrc(3) - ALUSrc(1) - ImmSrc(1) - ALUControl(3) - 
        --         MemtoReg(1) - NoWrite_in(1)

    begin    
        case op is 
            when "00" => -- 00: data processing            
                
                case funct(5 downto 1) is
                
                        when "10100" => -- ADD Imm
                            flags := "0X01000000"; 
                        when "00100" => -- ADD Reg   
                            flags := "0000X00000";
                            
                        when "10010" => -- SUB Imm
                            flags := "0X01000100"; 
                        when "00010" => -- SUB Reg   
                            flags := "0000X00100";                           
                        
                        when "10000" => -- AND Imm
                            flags := "0X01001000"; 
                        when "00000" => -- AND Reg   
                            flags := "0000X01000";
                        
                        when "10001" => -- EOR Imm
                            flags := "0X01001100"; 
                        when "00001" => -- EOR Reg   
                            flags := "0000X01100";  
                                
                            
                        when "11101" => -- MOV Imm
                            flags := "0XX1010000"; 
                            
                        when "01101" =>
                            if (sh = "00") then -- LSL
                                flags := "00X0X11000";
                            elsif (sh = "10") then -- ASR
                                flags := "00X0X11100";
                            else
                                flags := "00X0X10000"; -- MOV Reg
                            end if;
                            
                        when "11111" => -- MVN Imm
                            flags := "0XX1010100"; 
                        when "01111" => -- MVN Reg   
                            flags := "00X0X10100";                            

                        when "11010" => -- CMP Imm
                            if (funct(0)='1') then
                                flags := "XX010001X1"; 
                            end if;
                            
                        when "01010" => -- CMP Reg                              
                            if (funct(0)='1') then
                                flags := "X000X001X1"; 
                            end if;
                            
                        when others => 
                            flags := "XXXXXXXXXX";
                    end case;                 
   
                            
            when "01" => -- memory
                case funct is
                    
                    when "011001" => -- LDR Imm +
                        flags := "0X01000010"; 
                    when "010001" => -- LDR Imm - 
                        flags := "0X01000110";
                        
                    when "011000" => -- STR Imm +
                        flags := "X1010000X0"; 
                    when "010000" => -- STR Imm - 
                        flags := "X1010001X0";                  
                    
                    when others => 
                        flags := "XXXXXXXXXX";
                end case;
                
            when "10" => -- branching
                case funct(5 downto 4) is
                    
                    when "10" => -- B Imm +
                        flags := "XX11100000"; 
                    
                    when "11" => -- BL
                        flags := "1X11100000"; 
                        
                    when others => 
                        flags := "XXXXXXXXXX";   
                  
                end case;
                
            when others => 
                  flags := "XXXXXXXXXX";
         end case;
         
         RegSrc(2 downto 0) <= flags(9 downto 7);
         ALUSrc <= flags(6);
         ImmSrc <= flags(5);
         ALUControl(2 downto 0) <=  flags(4 downto 2);
         MemtoReg <= flags(1);
         NoWrite_in <= flags(0);
                 
    end process;
end Behavioral;
