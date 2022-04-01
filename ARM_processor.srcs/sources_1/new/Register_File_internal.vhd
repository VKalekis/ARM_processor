----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Vasilis Kalekis - HA 2020507
-- 
-- Create Date: 28.02.2021 12:39:07
-- Design Name: ARM Processor
-- Module Name: Register_File_internal - Behavioral
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

-- Internal Register file. Contains R0-R14
-- Reads RD1 from address A1 or reads RD2 from address A2 or writes data WD3 at address A3
entity Register_File_internal is
    generic (
        N : positive := 4;
        M : positive := 32);  
        
    port (
        CLK, WE3 : in STD_LOGIC;
        A1, A2, A3 : in STD_LOGIC_VECTOR (N-1 downto 0);
        WD3 : in STD_LOGIC_VECTOR (M-1 downto 0);
        RD1, RD2 : out STD_LOGIC_VECTOR (M-1 downto 0));  
end Register_File_internal;

architecture Behavioral of Register_File_internal is

    type RF_array is array (2**N-1 downto 0)
        of STD_LOGIC_VECTOR (M-1 downto 0);
    signal RF : RF_array;
    
    begin
    
    
    REG_FILE: process (CLK)
    begin
        if (CLK = '1' and CLK'event) then
            if (WE3 = '1') then
                RF(to_integer(unsigned(A3))) <= WD3;
            end if;
        end if;
    end process;  
   
   returnReg: process(A1,A2)
   begin
      if (A1 /= (A1'range => '1')) then  
          RD1 <= RF(to_integer(unsigned(A1)));  
      end if;  
      if (A2 /= (A2'range => '1')) then  
          RD2 <= RF(to_integer(unsigned(A2)));  
      end if;
   end process;
 
end Behavioral;
