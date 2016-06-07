; The functios below work definitely together
; We first call READ_DEC and after that PRODUCE_DEC
; All registers are modified
; The digits we can read are 4
; If we wish to read less than 4 digits we modify the instruction MOV CX,4
; which is located at the first line of each function
; Result : DX
; The result is the actual number we read
; The number we read is also printed

READ_DEC PROC NEAR
    MOV CX,4
    MOV BX,0
AGAIN:
    READ
    CMP AL,30H
    JL  AGAIN
    CMP AL,39H
    JG  AGAIN
    SAL BX,4
    PUSH AX
    PUSH DX
    PRINT AL
    POP DX
    POP AX
    MOV AH,0
    SUB AL,30H
    ADD BX,AX
    LOOP AGAIN
    RET
END1:
    MOV DL,AL
    PUSH DX
    PRINT AL
    POP DX
    RET
READ_DEC ENDP

PRODUCE_DEC PROC NEAR
    MOV CX,4
    MOV DX,0
ADDR1:    
    MOV AX,10
    MUL DX
    MOV DX,AX
    ROL BX,4
    MOV AX,BX
    AND AX,000FH
    ADD DX,AX 
    LOOP ADDR1
    MOV CX,DX
    RET
PRODUCE_DEC ENDP

; Transforms to dec and prints
; Takes the number through register DX
; Modifies all registers

PRINT_DEC PROC NEAR
    MOV BX,0
    MOV CX,0
LOOP1:
    SUB DX,2710H
    CMP DX,0
    JL  EXIT1
    INC BH
    JMP LOOP1
EXIT1:
    ADD BH,30H
    ADD DX,2710H
LOOP2:
    SUB DX,03E8H
    CMP DX,0
    JL  EXIT2
    INC BL
    JMP LOOP2
EXIT2:
    ADD BL,30H
    ADD DX,03E8H
LOOP3:
    SUB DX,64H
    CMP DX,0
    JL  EXIT3
    INC CH
    JMP LOOP3
EXIT3:     
    ADD CH,30H
    ADD DX,64H
LOOP4:
    SUB DX,0AH
    CMP DX,0
    JL  EXIT4
    INC CL
    JMP LOOP4
EXIT4:
    ADD CL,30H
    ADD DX,0AH
    ADD DX,30H
    CMP BH,30H
    JE  NOT_ALL
    PUSH DX
    PRINT BH
    POP DX
NOT_ALL:
    PUSH DX    
    PRINT BL
    PRINT CH
    PRINT CL
    POP DX
    PRINT DL
    RET
PRINT_DEC ENDP
