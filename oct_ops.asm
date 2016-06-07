; Reads oct digit
; Result : AL

READ_OCT_DIGIT PROC NEAR
OCT_DIGIT:
    READ
    CMP AL,30H
    JL  OCT_DIGIT
    CMP AL,37H
    JG  OCT_DIGIT
    PRINT AL
    SUB 30H
    RET
READ_OCT_DIGIT ENDP

; Reads a n-digit oct where n = DL
; Result : BX
; Modifies all registers
; READ_OCT_DIGIT is required

READ_N_DIGIT_OCT PROC NEAR
    MOV BX,0
N_DIGIT_OCT:
    MOV CL,3
    ROL BX,CL
    CALL READ_OCT_DIGIT
    ADD BL,AL
    DEC DL
    CMP DL,00H
    JG  N_DIGIT_OCT
    RET 
READ_N_DIGIT_OCT ENDP

; Prints a 5-digit oct number
; Takes the number from CX
; Modifies AX,BX,DX

PRINT_OCT PROC NEAR
    MOV BX,CX
    AND CX,07000H
    ROR CH,1
    ROR CH,1
    ROR CH,1
    ROR CH,1
    ADD CH,30H
    PRINT CH
    MOV CX,BX
    AND CX,0E00H
    ROR CH,1
    ADD CH,30H
    PRINT CH
    MOV CX,BX
    AND CX,01F0H
    ROL CX,1
    ROL CX,1          
    ADD CH,30H
    PRINT CH
    MOV CX,BX
    AND CX,0038H
    ROR CL,1
    ROR CL,1
    ROR CL,1
    ADD CL,30H
    PRINT CL
    MOV CX,BX
    AND CX,07H
    ADD CL,30H
    PRINT CL
    MOV CX,BX
    RET    
PRINT_OCT ENDP

