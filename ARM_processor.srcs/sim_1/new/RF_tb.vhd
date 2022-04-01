----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Vasilis Kalekis - HA 2020507
-- 
-- Create Date: 28.02.2021 13:31:23
-- Design Name: ARM Processor
-- Module Name: RF_tb - Behavioral
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

entity RF_tb is
    
end RF_tb;

architecture Behavioral of RF_tb is
    
    component Register_File is
    generic (
        REG_WIDTH : positive := 4;
        WIDTH : positive := 32);  
        
    port (
        WE3, CLK : in STD_LOGIC;
        A1, A2, A3 : in STD_LOGIC_VECTOR (M-1 downto 0) ;
        R15, WD3 : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
        RD1, RD2 : out STD_LOGIC_VECTOR (WIDTH-1 downto 0));  
    end component;  
    
    shared variable M : positive := 4;
    shared variable WIDTH : positive := 32;
    signal  WE3_tb, CLK : STD_LOGIC;
    signal  A1_tb, A2_tb, A3_tb : STD_LOGIC_VECTOR (M-1 downto 0);
    signal  R15_tb, WD3_tb, RD1_tb, RD2_tb : STD_LOGIC_VECTOR (WIDTH-1 downto 0);
    
    constant CLK_period : time := 10.000 ns;
    
begin

    RF: Register_file
        generic map(
            M => 4,
            WIDTH => 32
        )
        port map (
            CLK => CLK,
            WE3 => WE3_tb,
            A1 => A1_tb, 
            A2 => A2_tb,
            A3 => A3_tb,
            R15 => R15_tb,
            WD3 => WD3_tb,
            RD1 => RD1_tb,
            RD2 => RD2_tb);

    
    CLK_process : process
    begin
        CLK <= '0';
        wait for CLK_period/2;
        CLK <= '1';
        wait for CLK_period/2;
    end process;
    
    
    Stimulus_process: process
	begin
-- 	Synchronous RESET is deasserted on CLK falling edge 
-- after GSR signal disable (it remains enabled for 100 ns)
--		RESET <= '1';
--        wait for 100 ns;
--        wait until (CLK = '0' and CLK'event);
--		RESET <= '0';
    WE3_tb <= '1';
	R15_tb <= X"000000" & "00000101";
	
	A3_tb <= "0010";
	WD3_tb <= X"000000" & "00010000";
	wait for CLK_period;
	
	A3_tb <= "0011";
	WD3_tb <= X"000000" & "00011111";
	wait for CLK_period;
	
	A3_tb <= "0111";
	WD3_tb <= X"000000" & "00000001";
	wait for CLK_period;
	
	A1_tb <= "0010";
	wait for 2*CLK_period;
	
	A2_tb <= "1111";
	wait for 2*CLK_period;
	
	A1_tb <= "0011";
	wait for 2*CLK_period;
	
	A2_tb <= "0111";
	wait for 2*CLK_period;
		
	end process;
end Behavioral;
