----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Vasilis Kalekis - HA 2020507
-- 
-- Create Date: 28.02.2021 12:25:38
-- Design Name: ARM Processor
-- Module Name: Instruction_Memory - Behavioral
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


-- ROM Array with 2^N words of width M bits. 
-- Default: N=6, M=32
entity Instruction_Memory is
     generic (
        N : positive := 6;
        WIDTH : positive := 32);    
    
    port(
        A : in STD_LOGIC_VECTOR (N-1 downto 0);
        RD : out STD_LOGIC_VECTOR (WIDTH-1 downto 0));
end Instruction_Memory;

architecture Behavioral of Instruction_Memory is

    type IM_array is array (0 to 2**N-1)
        of STD_LOGIC_VECTOR (WIDTH-1 downto 0);
    constant IM : IM_array := (    
       
        X"E3A00004",X"E3E01000",X"E5800004",X"E2802004",
        X"E5923000",X"E1530002",X"90034002",X"01A05403",
        X"11A05203",X"E2911001",X"60216002",X"72206008",
        X"03E070FF",X"01A08247",X"2580800C",X"EBFFFFEF",

   
        X"00000000", X"00000000", X"00000000", X"00000000",
        X"00000000", X"00000000", X"00000000", X"00000000",
        X"00000000", X"00000000", X"00000000", X"00000000",
        X"00000000", X"00000000", X"00000000", X"00000000",
        
        X"00000000", X"00000000", X"00000000", X"00000000",
        X"00000000", X"00000000", X"00000000", X"00000000",
        X"00000000", X"00000000", X"00000000", X"00000000",
        X"00000000", X"00000000", X"00000000", X"00000000",
        
        X"00000000", X"00000000", X"00000000", X"00000000",
        X"00000000", X"00000000", X"00000000", X"00000000",
        X"00000000", X"00000000", X"00000000", X"00000000",
        X"00000000", X"00000000", X"00000000", X"00000000");
        

        
begin

RD <= IM(to_integer(unsigned(A)));

end Behavioral;
