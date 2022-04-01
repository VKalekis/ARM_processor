----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Vasilis Kalekis - HA 2020507
-- 
-- Create Date: 28.02.2021 12:03:07
-- Design Name: ARM Processor
-- Module Name: Datapath - Structural
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

entity Datapath is
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
end Datapath;

architecture Structural of Datapath is
    
    component REG_n is
        generic (WIDTH : positive := 32);
        port (
            CLK, RESET, WE : in STD_LOGIC;
            D: in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
            Q: out STD_LOGIC_VECTOR (WIDTH-1 downto 0));   
    end component;
    
    component MUX_n is
        generic (WIDTH : positive := 32);
        port (
            A0, A1 : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
            S : in STD_LOGIC;
            Y : out STD_LOGIC_VECTOR (WIDTH-1 downto 0));
    end component;
    
    component Instruction_Memory is
         generic (
            N : positive := 6;
            WIDTH : positive := 32);     
        port(
            A : in STD_LOGIC_VECTOR (N-1 downto 0);
            RD : out STD_LOGIC_VECTOR (WIDTH-1 downto 0));
    end component;
    
    component INC4 is
         generic (WIDTH : positive := 32);
         port ( 
            X: in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
            Y: out STD_LOGIC_VECTOR (WIDTH-1 downto 0));
    end component;    
   
    component Register_File is
        generic (
            N : positive := 4;
            M : positive := 32);        
        port (
            WE3, CLK : in STD_LOGIC;
            A1, A2, A3 : in STD_LOGIC_VECTOR (N-1 downto 0);
            R15, WD3 : in STD_LOGIC_VECTOR (M-1 downto 0);
            RD1, RD2 : out STD_LOGIC_VECTOR (M-1 downto 0));  
    end component;
    
    component Extend is
        generic (WIDTH : positive := 32);
        port ( 
            X: in STD_LOGIC_VECTOR (23 downto 0);
            S : in STD_LOGIC;
            Y: out STD_LOGIC_VECTOR (WIDTH-1 downto 0));
    end component;
    
    component ALU is
        generic (WIDTH : positive := 32);
        port (
            SrcA, SrcB : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
            ALUControl : in STD_LOGIC_VECTOR (2 downto 0);
            shamt5 : in STD_LOGIC_VECTOR (4 downto 0);
            ALUResult : out STD_LOGIC_VECTOR (WIDTH-1 downto 0);
            NZCV : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    component Data_Memory is
        generic (
            N : positive := 5;
            M : positive := 32);     
        port (
            CLK, WE : in STD_LOGIC;
            A : in STD_LOGIC_VECTOR (N-1 downto 0);
            WD : in STD_LOGIC_VECTOR (M-1 downto 0);
            RD : out STD_LOGIC_VECTOR (M-1 downto 0));
    end component;
    
    signal PCN, PC_int, Instr_int, PCPlus4, PCPlus8, ExtImm, SrcB, WD3, RD1, RD2, ALUResult_int, RD, Result_int : STD_LOGIC_VECTOR (BUS_WIDTH-1 downto 0);    
    signal NZCV: STD_LOGIC_VECTOR (3 downto 0);
    
    signal RA1, RA2, WA : STD_LOGIC_VECTOR (REG_WIDTH-1 downto 0);
begin

    PC_REG: REG_n
        generic map (
            WIDTH => BUS_WIDTH)
        port map (
            CLK => CLK,
            RESET => RESET,
            WE => '1',
            D => PCN,
            Q => PC_int
            );
    
    IM: Instruction_Memory 
         generic map (
            N => N_IM,
            WIDTH => BUS_WIDTH)     
        port map (
            A => PC_int(N_IM+1 downto 2),
            RD => Instr_int);
            
    PCPlus4_INC: INC4 
         generic map (
            WIDTH => BUS_WIDTH)
         port map( 
            X => PC_int,
            Y => PCPlus4);
    
    RA1_Rn_or_15_MUX: MUX_n
        generic map (
            WIDTH => REG_WIDTH)
        port map(
            A0 => Instr_int(19 downto 16),
            A1 => "1111",
            S => RegSrc(0),
            Y => RA1);
    
    RA2_Rm_or_Rd_MUX: MUX_n
        generic map (
            WIDTH => REG_WIDTH)
        port map(
            A0 => Instr_int(3 downto 0),
            A1 => Instr_int(15 downto 12),
            S => RegSrc(1),
            Y => RA2);
     
    WA_Rd_or_14_MUX: MUX_n
        generic map (
            WIDTH => REG_WIDTH)
        port map(
            A0 => Instr_int(15 downto 12),
            A1 => "1110",
            S => RegSrc(2),
            Y => WA);
            
    PCPlus8_INC: INC4 
         generic map (
            WIDTH => BUS_WIDTH)
         port map( 
            X => PCPlus4,
            Y => PCPlus8);
            
    RegFile: Register_file
         generic map (
            N => REG_WIDTH,
            M => BUS_WIDTH)
         port map(
            WE3 => RegWrite,
            CLK => CLK,
            A1 => RA1,
            A2 => RA2,
            A3 => WA,
            R15 => PCPlus8,
            WD3 => WD3,
            RD1 => RD1,
            RD2 => RD2 );        
        
    Extension: Extend
        generic map(
            WIDTH => BUS_WIDTH)
        port map(
            X => Instr_int(23 downto 0),
            S => ImmSrc,
            Y => ExtImm);
            
    SrcB_RD2_or_ExtImm_MUX: MUX_n
        generic map(
            WIDTH => BUS_WIDTH)
        port map(
            A0 => RD2,
            A1 => ExtImm,
            S => ALUSrc,
            Y => SrcB);
    
    ALU_instance: ALU 
        generic map (
            WIDTH => BUS_WIDTH)
        port map (
            SrcA => RD1,
            SrcB => SrcB,
            ALUControl => ALUControl,
            shamt5 => Instr_int(11 downto 7),
            ALUResult => ALUResult_int,
            NZCV => NZCV);
    
    StatusRegister: REG_n
        generic map (
            WIDTH => 4)
        port map (
            CLK => CLK,
            RESET => RESET, 
            WE => FlagsWrite,
            D => NZCV,
            Q => Flags);
            
     DM: Data_Memory
        generic map(
            N => N_DM,
            M => BUS_WIDTH)
        port map (
            CLK => CLK,
            WE => MemWrite,
            A => ALUResult_int(N_DM+1 downto 2),
            WD => RD2,
            RD => RD);      
     
     Result_ALUResult_or_RD_MUX: MUX_n
        generic map(
            WIDTH => BUS_WIDTH)
        port map(
            A0 => ALUResult_int,
            A1 => RD,
            S => MemtoReg,
            Y => Result_int);
    
    WD3_Result_or_PCPlus4_MUX: MUX_n
        generic map(
            WIDTH => BUS_WIDTH)
        port map(
            A0 => Result_int,
            A1 => PCPlus4,
            S => RegSrc(2),
            Y => WD3);
            
    PCN_PCPlus4_or_Result_MUX: MUX_n
        generic map(
            WIDTH => BUS_WIDTH)
        port map(
            A0 => PCPlus4,
            A1 => Result_int,
            S => PCSrc,
            Y => PCN);
    
    PC <= PC_int;
    Instr <= Instr_int;
    ALUResult <= ALUResult_int;
    WriteData <= RD2;
    Result <= Result_int;     
end Structural;
