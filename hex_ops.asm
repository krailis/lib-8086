; Reads a n-digit hexadecimal number where n = DL
; While reading it exits if Q or q is pressed
; Result : BX
; Modifies all registers

READ_HEX_DIGIT PROC NEAR
NUMBER:
    READ
    CMP AL,51H
    JE  ENDING
    CMP AL,71H
    JE  ENDING
    CMP AL,30H
    JL  NUMBER
    CMP AL,39H
    JG  LETTER
    PRINT AL
    SUB AL,30H
    RET
LETTER:
    CMP AL,41H
    JL  NUMBER
    CMP AL,46H
    JG  NUMBER
    PRINT AL
    SUB AL,37H
    RET    
READ_HEX_DIGIT ENDP

READ_N_DIGIT_HEX PROC NEAR
    MOV BX,0
N_DIGIT_HEX: 
    MOV CL,4
    ROL BX,CL    
    PUSH DX
    CALL READ_HEX_DIGIT
    POP DX
    DEC DL
    ADD BL,AL
    CMP DL,00H
    JG  N_DIGIT_HEX
    RET
READ_N_DIGIT_HEX ENDP

; Takes a number and prints it in hexadecimal form
; Modifies AX,BX
; Takes the initial number through CX

PRINT_HEX_DIGIT PROC NEAR
    CMP AL,09H
    JG  LETTER
NUMBER:
    ADD AL,30H
    PRINT AL
    RET
LETTER:
    ADD AL,37H
    PRINT AL
    RET
PRINT_HEX_DIGIT ENDP

PRINT_HEX PROC NEAR
    MOV BX,CX
    AND CX,0F000H
    ROR CH,1
    ROR CH,1
    ROR CH,1
    ROR CH,1
    MOV AL,CH
    CALL PRINT_HEX_DIGIT
    MOV CX,BX
    AND CX,0F00H
    MOV AL,CH
    CALL PRINT_HEX_DIGIT
    MOV CX,BX
    AND CX,00F0H
    ROR CL,1
    ROR CL,1
    ROR CL,1
    ROR CL,1          
    MOV AL,CL
    CALL PRINT_HEX_DIGIT
    MOV CX,BX
    AND CX,000FH
    MOV AL,CL
    CALL PRINT_HEX_DIGIT
	MOV CX,BX
    RET
PRINT_HEX ENDP
