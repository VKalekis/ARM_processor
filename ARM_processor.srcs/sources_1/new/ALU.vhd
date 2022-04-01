----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Vasilis Kalekis - HA 2020507
-- 
-- Create Date: 01.03.2021 16:35:23
-- Design Name: ARM Processor
-- Module Name: ALU - Behavioral
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

entity ALU is
    generic (WIDTH : positive := 32);
    port (
        SrcA, SrcB : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
        ALUControl : in STD_LOGIC_VECTOR (2 downto 0);
        shamt5 : in STD_LOGIC_VECTOR (4 downto 0);
        ALUResult : out STD_LOGIC_VECTOR (WIDTH-1 downto 0);
        NZCV : out STD_LOGIC_VECTOR (3 downto 0));
end ALU;

architecture Behavioral of ALU is
    
    component ADD_SUB is
        generic (WIDTH : positive := 32);
        port (
            SrcA, SrcB : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
            ALUControl : in STD_LOGIC_VECTOR (2 downto 0);
            ADD_SUB_result : out STD_LOGIC_VECTOR (WIDTH-1 downto 0);
            C_inV_in : out STD_LOGIC_VECTOR (1 downto 0));
    end component;
    
    component AND_XOR is
        generic (WIDTH : positive := 32);
        port (
            SrcA, SrcB : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
            ALUControl : in STD_LOGIC_VECTOR (2 downto 0);
            AND_XOR_result : out STD_LOGIC_VECTOR (WIDTH-1 downto 0));
    end component; 
    
    component MOV_MVN is
        generic (WIDTH : positive := 32);
        port (
            SrcB : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
            ALUControl : in STD_LOGIC_VECTOR (2 downto 0);
            MOV_MVN_result : out STD_LOGIC_VECTOR (WIDTH-1 downto 0));
    end component;
    
    component LSL_ASR is
        generic (WIDTH : positive := 32);
        port (
            SrcB : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
            ALUControl : in STD_LOGIC_VECTOR (2 downto 0);
            shamt5 : in STD_LOGIC_VECTOR (4 downto 0);
            LSL_ASR_result : out STD_LOGIC_VECTOR (WIDTH-1 downto 0));
    end component;
    
    signal ADD_SUB_result_in, AND_XOR_result_in, MOV_MVN_result_in, LSL_ASR_result_in, ALUResult_in : STD_LOGIC_VECTOR (WIDTH-1 downto 0);
    signal C_inV_in : STD_LOGIC_VECTOR (1 downto 0);
begin

    ADD_SUB_instance: ADD_SUB
        generic map (WIDTH => WIDTH)
        port map (
            SrcA => SrcA,
            SrcB => SrcB,
            ALUControl => ALUControl,
            ADD_SUB_result => ADD_SUB_result_in,
            C_inV_in => C_inV_in);
        
    AND_XOR_instance: AND_XOR
        generic map (WIDTH => WIDTH)
        port map (
            SrcA => SrcA,
            SrcB => SrcB,
            ALUControl => ALUControl,
            AND_XOR_result => AND_XOR_result_in);
     
    MOV_MVN_instance: MOV_MVN
        generic map (WIDTH => WIDTH)
        port map (            
            SrcB => SrcB,
            ALUControl => ALUControl,
            MOV_MVN_result => MOV_MVN_result_in);
     
    LSL_ASR_instance: LSL_ASR
        generic map (WIDTH => WIDTH)
        port map (
            SrcB => SrcB,
            ALUControl => ALUControl,
            shamt5 => shamt5,
            LSL_ASR_result => LSL_ASR_result_in);
    
    correct_output: process(ALUControl, ADD_SUB_result_in, AND_XOR_result_in, MOV_MVN_result_in, LSL_ASR_result_in, ALUControl)
    begin
        case ALUControl is
            when "000" => --ADD
                ALUResult_in <= ADD_SUB_result_in;
            when "001" => --SUB
                ALUResult_in <= ADD_SUB_result_in;
            when "010" => --AND
                ALUResult_in <= AND_XOR_result_in;
            when "011" => --XOR
                ALUResult_in <= AND_XOR_result_in;
            when "100" => --MOV
                ALUResult_in <= MOV_MVN_result_in;
            when "101" => --MVN
                ALUResult_in <= MOV_MVN_result_in;
            when "110" => --LSL
                ALUResult_in <= LSL_ASR_result_in;
            when "111" => --ASR
                ALUResult_in <= LSL_ASR_result_in;
            when others =>
                ALUResult_in <= (others => 'X');
        end case;        
    end process;    
    
    
    flagsAndupdate: process (ALUResult_in, ALUControl)    
    begin
        -- Z Flag
        if (ALUResult_in = (ALUResult_in'range => '0')) then
            NZCV(2)<='1';
        else
            NZCV(2)<='0';
        end if;       
      
        -- V Flag    
        NZCV(0) <= C_inV_in(0) and (not ALUControl(1)) and (not ALUControl(2)); 
        -- C Flag
        NZCV(1) <= C_inV_in(1) and (not ALUControl(1)) and (not ALUControl(2));      
        -- N Flag
        NZCV(3) <= ALUResult_in(WIDTH-1);
        
        ALUResult <= ALUResult_in;  
    end process;
    
   
    
end Behavioral;
