----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Vasilis Kalekis - HA 2020507
-- 
-- Create Date: 03.03.2021 17:57:44
-- Design Name: ARM Processor
-- Module Name: Processor - Structural
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

entity Processor is
     generic (
        BUS_WIDTH : positive := 32);
    port (

        
        CLK, RESET : in STD_LOGIC;
        PC, Instr, ALUResult, WriteData : out STD_LOGIC_VECTOR (BUS_WIDTH-1 downto 0));
         
        
end Processor;

architecture Structural of Processor is
    
    component Datapath is
        generic (
            BUS_WIDTH : positive := 32;
            REG_WIDTH : positive := 4;
            N_IM : positive := 6;
            N_DM : positive := 5);
        port (
            CLK, RESET, RegWrite, ImmSrc, ALUSrc, FlagsWrite, MemWrite, MemtoReg, PCSrc : in STD_LOGIC;
            RegSrc : in STD_LOGIC_VECTOR (2 downto 0);
            ALUControl : in  STD_LOGIC_VECTOR (2 downto 0);
            
            Flags : out STD_LOGIC_VECTOR (3 downto 0);
            PC : out STD_LOGIC_VECTOR (BUS_WIDTH-1 downto 0);
            Instr : out STD_LOGIC_VECTOR (BUS_WIDTH-1 downto 0);
            ALUResult : out STD_LOGIC_VECTOR (BUS_WIDTH-1 downto 0);
            WriteData : out STD_LOGIC_VECTOR (BUS_WIDTH-1 downto 0);
            Result : out STD_LOGIC_VECTOR (BUS_WIDTH-1 downto 0));
    end component;
    
    component Control is
        generic (
            BUS_WIDTH : positive := 32);
        port (        
            Instr : in STD_LOGIC_VECTOR (BUS_WIDTH-1 downto 0);
            Flags : in STD_LOGIC_VECTOR (3 downto 0);
    
            RegWrite, ImmSrc, ALUSrc, FlagsWrite, MemWrite, MemtoReg, PCSrc : out STD_LOGIC;
            RegSrc : out STD_LOGIC_VECTOR (2 downto 0);
            ALUControl : out  STD_LOGIC_VECTOR (2 downto 0));
    end component;
    
    signal RegWrite, ImmSrc, ALUSrc, FlagsWrite, MemWrite, MemtoReg, PCSrc : STD_LOGIC;
    signal RegSrc : STD_LOGIC_VECTOR (2 downto 0);
    signal ALUControl : STD_LOGIC_VECTOR (2 downto 0);
            
    signal  Flags : STD_LOGIC_VECTOR (3 downto 0);
    signal  PC_in, Instr_in : STD_LOGIC_VECTOR (BUS_WIDTH-1 downto 0);

    signal Result : STD_LOGIC_VECTOR (BUS_WIDTH-1 downto 0);
begin
    
    Datapath_instance: Datapath
        generic map(            
            BUS_WIDTH => BUS_WIDTH,
            REG_WIDTH => 4,
            N_IM => 6,
            N_DM => 5)
        port map (
            CLK => CLK,
            RESET => RESET,
            RegWrite => RegWrite, 
            ImmSrc => ImmSrc, 
            ALUSrc => ALUSrc, 
            FlagsWrite => FlagsWrite, 
            MemWrite => MemWrite, 
            MemtoReg => MemtoReg, 
            PCSrc => PCSrc,
            RegSrc => RegSrc,
            ALUControl => ALUControl,
            
            Flags => Flags,
            PC => PC_in,
            Instr => Instr_in,
            ALUResult => ALUResult,
            WriteData => WriteData,
            Result => Result);
    
    Control_instance: Control
        generic map(
            BUS_WIDTH => BUS_WIDTH)
        port map (        
        Instr => Instr_in,
        Flags => Flags,

        RegWrite => RegWrite, 
        ImmSrc => ImmSrc, 
        ALUSrc => ALUSrc, 
        FlagsWrite => FlagsWrite, 
        MemWrite => MemWrite, 
        MemtoReg => MemtoReg, 
        PCSrc => PCSrc,
        RegSrc => RegSrc,
        ALUControl => ALUControl);
        
   
    PC <= PC_in;
    Instr <= Instr_in;
end Structural;
