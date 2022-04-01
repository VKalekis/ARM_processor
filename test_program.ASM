MAIN_PROGRAM:
MOV R0, #4              ;R0=X"00000004"
MVN R1, #0              ;R1=X"FFFFFFFF"
STR R0, [R0, #4]        ;DM[2]=X"00000004"
ADD R2, R0, #4          ;R2=X"00000008"
LDR R3, [R2, #0]        ;R3=DM[2]=X"00000004"
CMP R3, R2              ;R3-R2=X"00000004"-X"00000008" < 0
                        ;updates flags -> 1000
ANDLS R4, R3, R2        ;R4=R3 AND R2 = X"00000000"
LSLEQ R5, R3, #8        ;Will not execute.
LSLNE R5, R3, #4        ;R5=R3 LSL 4 = X"000000080"
ADDS R1, R1, #1         ;R1=X"00000000" with overflow of 32bit word,
                        ;updates flags -> 0110
EORVS R6, R1, R2        ;Will not execute, no overflow
EORVC R6, R0, #8        ;R6=R1 XOR X"00000008"=X"0000000C"
MVNEQ R7, #255          ;R7=X"FFFFFF00"
ASREQ R8, R7, #4        ;R8=X"FFFFFFF0"
STRCS R8, [R0, #12]     ;DM[4]=X"FFFFFFF0"
BL MAIN_PROGRAM