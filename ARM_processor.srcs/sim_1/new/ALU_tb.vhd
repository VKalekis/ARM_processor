----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Vasilis Kalekis - HA 2020507
-- 
-- Create Date: 01.03.2021 17:17:50
-- Design Name: ARM Processor
-- Module Name: ALU_tb - Behavioral
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

entity ALU_tb is
--  Port ( );
end ALU_tb;

architecture Behavioral of ALU_tb is

    component ALU is
    generic (WIDTH : positive := 32);
    port (
        SrcA, SrcB : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
        ALUControl : in STD_LOGIC_VECTOR (2 downto 0);
        shamt5 : in STD_LOGIC_VECTOR (4 downto 0);
        ALUResult : out STD_LOGIC_VECTOR (WIDTH-1 downto 0);
        NZCV : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    shared variable WIDTH1 : positive := 4;
    constant CLK_period : time := 10.000 ns;
    signal SrcA_tb, SrcB_tb, ALUResult_tb : STD_LOGIC_VECTOR (WIDTH1-1 downto 0);
    signal ALUControl_tb : STD_LOGIC_VECTOR (2 downto 0);
    signal NZCV_tb : STD_LOGIC_VECTOR (3 downto 0);
    signal shamt5_tb : STD_LOGIC_VECTOR (4 downto 0);
    signal CLK : STD_LOGIC;
begin

    ALU1: ALU 
    generic map (WIDTH => 4)
    port map (
        SrcA => SrcA_tb,
        SrcB => SrcB_tb,
        ALUControl => ALUControl_tb,
        shamt5 => shamt5_tb,
        ALUResult => ALUResult_tb,
        NZCV => NZCV_tb);
  
  
  CLK_process : process
    begin
        CLK <= '0';
        wait for CLK_period/2;
        CLK <= '1';
        wait for CLK_period/2;
    end process;
    
    Stimulus_process: process
	begin
	   
--	   SrcA_tb <= X"00000101";
--	   SrcB_tb <= X"00000010";
--	   ALUControl_tb <= "010";
--	   wait for 2*CLK_period;
	   
--	   SrcA_tb <= X"00000101";
--	   SrcB_tb <= X"00000010";
--	   ALUControl_tb <= "011";
--	   wait for 2*CLK_period;
	   
--	   SrcA_tb <= X"00000101";
--	   SrcB_tb <= X"00000101";
--	   ALUControl_tb <= "001";
--       wait for 2*CLK_period;
       
--       SrcA_tb <= X"00001101";
--	   SrcB_tb <= X"00000101";
--	   ALUControl_tb <= "000";
--       wait for 2*CLK_period;
       
--       SrcA_tb <= X"00000101";
--	   SrcB_tb <= X"00000101";
--	   ALUControl_tb <= "000";
--       wait for 2*CLK_period;
       
       
--       SrcA_tb <= X"00000101";
--	   SrcB_tb <= X"00001011";
--	   ALUControl_tb <= "100";
--       wait for 2*CLK_period;
       
--       SrcA_tb <= X"00000101";
--	   SrcB_tb <= X"00001011";
--	   ALUControl_tb <= "101";
--       wait for 2*CLK_period;
       
--       shamt5_tb <= "00100"; 
--       SrcA_tb <= X"00000101";
--	   SrcB_tb <= X"00001011";
--	   ALUControl_tb <= "110";
--       wait for 2*CLK_period; 
       
--       SrcA_tb <= X"00000101";
--	   SrcB_tb <= X"00001011";
--	   ALUControl_tb <= "111";
--       wait for 2*CLK_period;
       
--       shamt5_tb <= "01000"; 
--       SrcA_tb <= X"00000101";
--	   SrcB_tb <= X"FF001011";
--	   ALUControl_tb <= "110";
--       wait for 2*CLK_period; 
       
--       SrcA_tb <= X"00000101";
--	   SrcB_tb <= X"FF001011";
--	   ALUControl_tb <= "111";
--       wait for 2*CLK_period;    

    shamt5_tb <= "00000";
    
--       SrcA_tb <= X"00000009";
--	   SrcB_tb <= X"00000002";
--	   ALUControl_tb <= "001";
--       wait for 2*CLK_period; 
       
--       SrcB_tb <= X"00000009";
--	   SrcA_tb <= X"00000002";
--	   ALUControl_tb <= "001";
--       wait for 2*CLK_period; 

       SrcA_tb <= "1001";
	   SrcB_tb <= "0010";
	   ALUControl_tb <= "001";
       wait for 2*CLK_period; 
       
       SrcB_tb <= "1001";
	   SrcA_tb <= "0010";
	   ALUControl_tb <= "001";
       wait for 2*CLK_period;       
      
       SrcA_tb <= "1001";
	   SrcB_tb <= "1110";
	   ALUControl_tb <= "000";
       wait for 2*CLK_period; 
       
	end process;
end Behavioral;
