----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Vasilis Kalekis - HA 2020507
-- 
-- Create Date: 03.03.2021 17:06:35
-- Design Name: ARM Processor
-- Module Name: Control - Structural
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

entity Control is
    generic (
        BUS_WIDTH : positive := 32);
    port (        
        Instr : in STD_LOGIC_VECTOR (BUS_WIDTH-1 downto 0);
        Flags : in STD_LOGIC_VECTOR (3 downto 0);

        RegWrite, ImmSrc, ALUSrc, FlagsWrite, MemWrite, MemtoReg, PCSrc : out STD_LOGIC;
        RegSrc : out STD_LOGIC_VECTOR (2 downto 0);
        ALUControl : out  STD_LOGIC_VECTOR (2 downto 0));
end Control;

architecture Structural of Control is
    
    component InstrDec is            
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
    end component;
    
    component WELogic is             
        port (
            op : in STD_LOGIC_VECTOR (1 downto 0);
            S : in STD_LOGIC;
            L : in STD_LOGIC;
            NoWrite_in : in STD_LOGIC;
            
            RegWrite_in : out STD_LOGIC;
            MemWrite_in : out STD_LOGIC;
            FlagsWrite_in : out STD_LOGIC);
    end component;
    
    component PCLogic is       
        port (
            Rd : in STD_LOGIC_VECTOR (3 downto 0);
            op : in STD_LOGIC_VECTOR (1 downto 0);
            RegWrite_in : in STD_LOGIC;
            
            PCSrc_in : out STD_LOGIC);
    end component;
    
    component CONDLogic is
        port (
            cond : in STD_LOGIC_VECTOR(3 downto 0);
            Flags : in STD_LOGIC_VECTOR(3 downto 0); --NZCV
            
            CondEx_in : out STD_LOGIC);
    end component;
    
    signal NoWrite_in, RegWrite_in, MemWrite_in, FlagsWrite_in, PCSrc_in, CondEx_in  : STD_LOGIC;
begin
                             
    InstrDec_instance: InstrDec              
        port map(
            op => Instr(27 downto 26),
            funct => Instr(25 downto 20),
            sh => Instr(6 downto 5),           
            RegSrc => RegSrc,
            ALUSrc => ALUSrc,
            ImmSrc => ImmSrc,
            ALUControl => ALUControl,
            MemtoReg => MemtoReg,
            NoWrite_in => NoWrite_in);
    
    WELogic_instance: WELogic
        port map(
            op => Instr(27 downto 26),  
            S => Instr(20),
            L => Instr(24),
            NoWrite_in => NoWrite_in,
            RegWrite_in => RegWrite_in,
            MemWrite_in => MemWrite_in,
            FlagsWrite_in => FlagsWrite_in);
    
    PCLogic_instance: PCLogic
        port map(
            Rd => Instr(15 downto 12),
            op => Instr(27 downto 26), 
            RegWrite_in => RegWrite_in,
            PCSrc_in => PCSrc_in);
            
    CONDLogic_instance: CONDLogic
        port map(
            cond => Instr(31 downto 28),
            Flags => Flags,
            CondEx_in => CondEx_in); 
    
    MemWrite <= MemWrite_in and CondEx_in;
    FlagsWrite <= FlagsWrite_in and CondEx_in;   
    RegWrite <= RegWrite_in and CondEx_in;   
    PCSrc <= PCSrc_in and CondEx_in;
                 
end Structural;