----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Vasilis Kalekis - HA 2020507
-- 
-- Create Date: 01.03.2021 16:24:21
-- Design Name: ARM Processor
-- Module Name: MUX_n - Behavioral
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

-- MUX: outputs A0 if S=0, A1 if S=1
entity MUX_n is
    generic (WIDTH : positive := 32);
    port (
        A0, A1 : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
        S : in STD_LOGIC;
        Y : out STD_LOGIC_VECTOR (WIDTH-1 downto 0));
end MUX_n;

architecture Behavioral of MUX_n is

begin
    
    process (A0, A1, S)
    begin
        if (S='0') then
            Y <= A0;
        else
            Y <= A1;
        end if;
    end process;

end Behavioral;
