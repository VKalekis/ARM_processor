----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Vasilis Kalekis - HA 2020507
-- 
-- Create Date: 28.02.2021 12:31:15
-- Design Name: ARM Processor
-- Module Name: Register_File - Behavioral
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


-- 2^N Registers with M M bits. O R15 einai o PC, ulopoieitai diaforetika.
-- Default: N=4, M=32
entity Register_File is
    generic (
        N : positive := 4;
        M : positive := 32);          
    port (
        WE3, CLK : in STD_LOGIC;
        A1, A2, A3 : in STD_LOGIC_VECTOR (N-1 downto 0);
        R15, WD3 : in STD_LOGIC_VECTOR (M-1 downto 0);
        RD1, RD2 : out STD_LOGIC_VECTOR (M-1 downto 0));  
end Register_File;

architecture Behavioral of Register_File is

    component Register_File_internal
        generic (                                             
            N : positive := 4;                                
            M : positive := 32);                              
                                                      
        port (                                                
            CLK, WE3 : in STD_LOGIC;                          
            A1, A2, A3 : in STD_LOGIC_VECTOR (N-1 downto 0);  
            WD3 : in STD_LOGIC_VECTOR (M-1 downto 0);         
            RD1, RD2 : out STD_LOGIC_VECTOR (M-1 downto 0));  
    end component;
    
    signal RD1_in, RD2_in : STD_LOGIC_VECTOR (M-1 downto 0);
 
begin    
   
    
    RF_internal: Register_File_internal
        generic map(
            N => N,
            M => M
        )
        port map (
            CLK => CLK,
            WE3 => WE3,
            A1 => A1, 
            A2 => A2,
            A3 => A3,
            WD3 => WD3,
            RD1 => RD1_in,
            RD2 => RD2_in);
            
    
   R15test: process(A1, A2, R15, RD1_in, RD2_in) 
   begin
        if (A1 = (A1'range => '1')) then
            RD1 <= R15;
        else 
            RD1 <= RD1_in;
        end if;
        
        if (A2 = (A2'range => '1')) then
            RD2 <= R15;
        else 
            RD2 <= RD2_in;
        end if;
    end process;      

end Behavioral;
