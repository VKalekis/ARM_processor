----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Vasilis Kalekis - HA 2020507
-- 
-- Create Date: 03.03.2021 20:01:21
-- Design Name: ARM Processor
-- Module Name: Control_tb - Behavioral
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

entity Control_tb is
--  Port ( );
end Control_tb;

architecture Behavioral of Control_tb is
    
    component Control
        generic (
            BUS_WIDTH : positive := 32;
            REG_WIDTH : positive := 4);
    --        N_IM : positive := 6;
    --        N_DM : positive := 5);
        port (        
            Instr : in STD_LOGIC_VECTOR (BUS_WIDTH-1 downto 0);
            Flags : in STD_LOGIC_VECTOR (3 downto 0);
    
            RegWrite, ImmSrc, ALUSrc, FlagsWrite, MemWrite, MemtoReg, PCSrc : out STD_LOGIC;
            RegSrc : out STD_LOGIC_VECTOR (2 downto 0);
            ALUControl : out  STD_LOGIC_VECTOR (1 downto 0));
     end component;
     
     shared variable BUS_WIDTH : positive := 32;
     constant CLK_period : time := 10.000 ns;
     signal CLK : STD_LOGIC;
     
     signal Instr_tb : STD_LOGIC_VECTOR (BUS_WIDTH-1 downto 0);
     signal Flags_tb : STD_LOGIC_VECTOR (3 downto 0);
     signal RegWrite_tb, ImmSrc_tb, ALUSrc_tb, FlagsWrite_tb, MemWrite_tb, MemtoReg_tb, PCSrc_tb : STD_LOGIC;
     signal RegSrc_tb : STD_LOGIC_VECTOR (2 downto 0);
     signal ALUControl_tb : STD_LOGIC_VECTOR (1 downto 0);
begin

    
    Control1: Control
        generic map(
            BUS_WIDTH => 32,
            REG_WIDTH => 4)
        port map(
            Instr => Instr_tb,
            Flags => Flags_tb,
            RegWrite => RegWrite_tb,
            ImmSrc => ImmSrc_tb,
            ALUSrc => ALUSrc_tb,
            FlagsWrite => FlagsWrite_tb,
            MemWrite => MemWrite_tb,
            MemtoReg => MemtoReg_tb,
            PCSrc => PCSrc_tb,
            RegSrc => RegSrc_tb,
            ALUControl => ALUControl_tb);            
    
    CLK_process : process
    begin
        CLK <= '0';
        wait for CLK_period/2;
        CLK <= '1';
        wait for CLK_period/2;
    end process;
    
    Stimulus_process: process
	begin
	   Instr_tb <= "11100010100001010001000000000000";
	   Flags_tb <= "0000";
	   wait for 10*CLK_period;
	   
	   Instr_tb <= "11100000100010001010000000000000";
	   Flags_tb <= "0000";
	   wait for 10*CLK_period;
	end process;
end Behavioral;
