----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Vasilis Kalekis - HA 2020507
-- 
-- Create Date: 04.03.2021 13:19:01
-- Design Name: ARM Processor
-- Module Name: Processor_tb - Behavioral
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

entity Processor_tb is
    --  Port ( );
end Processor_tb;

architecture Behavioral of Processor_tb is
    
    component Processor is
--         generic (
--            BUS_WIDTH : positive := 32);
        port (
            CLK, RESET : in STD_LOGIC;
            
            PC, Instr, ALUResult, WriteData : out STD_LOGIC_VECTOR (32-1 downto 0));
     end component;
     
     --constant CLK_period : time := 20 ns;
	 --constant CLK_period : time := 15 ns;
     constant CLK_period : time := 5.934 ns;
     signal CLK, RESET : STD_LOGIC;
     signal PC_tb, Instr_tb, ALUResult_tb, WriteData_tb, Result_tb : STD_LOGIC_VECTOR(31 downto 0);
begin

    Processor_instance: Processor
--        generic map(
--            BUS_WIDTH => 32)
        port map(
            CLK => CLK,
            RESET => RESET,
            PC => PC_tb,
            Instr => Instr_tb,
            ALUResult => ALUResult_tb,
            WriteData => WriteData_tb);
            --Result => Result_tb);
    
    CLK_process : process
    begin
        CLK <= '0';
        wait for CLK_period/2;
        CLK <= '1';
        wait for CLK_period/2;
    end process;        
    
    stimulus_process: process
    begin
        -- RESET deasserted on CLK falling edge
        RESET <= '1';
        wait for 100 ns;
        wait until (CLK = '0' and CLK'event);
        RESET <= '0'; 
        
        wait for 16*CLK_period;
        
      
   end process;
end Behavioral;
