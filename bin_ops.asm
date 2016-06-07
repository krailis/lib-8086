; Reads a binary digit

READ_BIN PROC NEAR
DO_READ_BIN:
    READ
    CMP AL,30H
    JL  DO_READ_BIN
    CMP AL,31H
    JG  DO_READ_BIN
    RET
READ_BIN ENDP

; Reads n-bit binary where n = DL
; Result : CX
; Modifies AX,CX,DX
        
READ_N_BIT_BINARY PROC NEAR
    MOV CX,00H
N_BIT_BIN:
    CALL READ_BIN
    PUSH DX     
    PRINT AL
    POP DX
    SUB AL,30H
    ROL CX,1
    ADD CL,AL
    DEC DL
    CMP DL,00H
    JG  N_BIT_BIN
    RET
READ_N_BIT_BINARY ENDP        

; Prints a n bit binary number
; To choose the number of bits we change the instruction MOV CX,16
; Modifies all registers

PRINT_BIN PROC NEAR
    MOV CX,16
    MOV BX,DX
PBIN:
    ROL BX,1
    MOV DX,BX
    AND DL,01H
    ADD DL,30H
    PRINT DL
    LOOP PBIN
    RET
PRINT_BIN ENDP
